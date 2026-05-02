from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify, Response
from otp import genotp
from cmail import send_mail
from stoken import endata, dedata
import bcrypt
import os
import psycopg
import razorpay
import pdfkit
from decimal import Decimal
from itsdangerous import SignatureExpired

app = Flask(__name__)
app.secret_key = "zoro@123"

# ---------------- DB CONNECTION ----------------

conn = psycopg.connect("postgresql://postgres.niulkyswfbtydsfotphf:Likitha%402003@aws-1-ap-southeast-1.pooler.supabase.com:5432/postgres")
cursor = conn.cursor()

# ---------------- RAZORPAY ----------------
client = razorpay.Client(auth=(
    os.getenv("RAZOR_KEY"),
    os.getenv("RAZOR_SECRET")
))

# ---------------- HOME ----------------
@app.route('/')
def home():
    return render_template('welcome.html')


# ---------------- INDEX ----------------
@app.route('/index')
def index():
    cursor = conn.cursor()
    cursor.execute("SELECT itemid,item_name,item_description,price,quantity,category,item_image FROM items")
    data = cursor.fetchall()
    return render_template('index.html', all_itemsdata=data)


# ---------------- ADMIN REGISTER ----------------
@app.route('/admincreate', methods=['GET','POST'])
def admincreate():
    if request.method == 'POST':
        email = request.form['email']
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) FROM admindata WHERE email=%s", (email,))
        if cursor.fetchone()[0] == 0:
            otp = genotp()
            data = request.form.to_dict()
            data['otp'] = otp
            send_mail(email, "OTP", f"Your OTP is {otp}")
            return redirect(url_for('adminotp', token=endata(data)))
        else:
            flash("Email exists")
    return render_template('admincreate.html')


@app.route('/adminotp/<token>', methods=['GET','POST'])
def adminotp(token):
    data = dedata(token)
    if request.method == 'POST':
        if request.form['otp'] == data['otp']:
            cursor = conn.cursor()
            pwd = bcrypt.hashpw(data['password'].encode(), bcrypt.gensalt())
            cursor.execute(
                "INSERT INTO admindata(username,email,password,address,agreed) VALUES(%s,%s,%s,%s,%s)",
                (data['username'], data['email'], pwd, data['address'], data['agree'])
            )
            conn.commit()
            flash("Registered")
            return redirect(url_for('adminlogin'))
        else:
            flash("Wrong OTP")
    return render_template('adminotp.html')


# ---------------- ADMIN LOGIN ----------------
@app.route('/adminlogin', methods=['GET','POST'])
def adminlogin():
    if request.method == 'POST':
        email = request.form['email']
        pwd = request.form['password'].encode()
        cursor = conn.cursor()
        cursor.execute("SELECT password FROM admindata WHERE email=%s", (email,))
        data = cursor.fetchone()
        if data and bcrypt.checkpw(pwd, data[0]):
            session['admin'] = email
            return redirect(url_for('adminpanel'))
        else:
            flash("Invalid login")
    return render_template('adminlogin.html')


@app.route('/adminpanel')
def adminpanel():
    if session.get('admin'):
        return render_template('adminpanel.html')
    return redirect(url_for('adminlogin'))


# ---------------- ADD ITEM ----------------
@app.route('/additem', methods=['GET','POST'])
def additem():
    if not session.get('admin'):
        return redirect(url_for('adminlogin'))

    if request.method == 'POST':
        f = request.files['file']
        filename = genotp() + f.filename
        f.save("static/" + filename)

        cursor = conn.cursor()
        cursor.execute("SELECT adminid FROM admindata WHERE email=%s", (session['admin'],))
        admin_id = cursor.fetchone()[0]

        cursor.execute("""
        INSERT INTO items(itemid,item_name,item_description,price,quantity,category,item_image,added_by)
        VALUES(gen_random_uuid(),%s,%s,%s,%s,%s,%s,%s)
        """, (
            request.form['title'],
            request.form['Description'],
            request.form['price'],
            request.form['quantity'],
            request.form['category'],
            filename,
            admin_id
        ))
        conn.commit()
        flash("Item added")

    return render_template('additem.html')


# ---------------- DELETE ----------------
@app.route('/delete/<itemid>')
def delete(itemid):
    cursor = conn.cursor()
    cursor.execute("DELETE FROM items WHERE itemid=%s", (itemid,))
    conn.commit()
    return redirect(url_for('index'))


# ---------------- UPDATE ----------------
@app.route('/update/<itemid>', methods=['GET','POST'])
def update(itemid):
    cursor = conn.cursor()
    if request.method == 'POST':
        cursor.execute("""
        UPDATE items SET item_name=%s,item_description=%s,price=%s,quantity=%s,category=%s
        WHERE itemid=%s
        """, (
            request.form['title'],
            request.form['Description'],
            request.form['price'],
            request.form['quantity'],
            request.form['category'],
            itemid
        ))
        conn.commit()
        return redirect(url_for('index'))

    cursor.execute("SELECT * FROM items WHERE itemid=%s", (itemid,))
    data = cursor.fetchone()
    return render_template('update_item.html', item_data=data)


# ---------------- USER REGISTER ----------------
@app.route('/signup', methods=['GET','POST'])
def signup():
    if request.method == 'POST':
        email = request.form['email']
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) FROM userdata WHERE email=%s", (email,))
        if cursor.fetchone()[0] == 0:
            otp = genotp()
            data = request.form.to_dict()
            data['otp'] = otp
            send_mail(email, "OTP", f"Your OTP is {otp}")
            return redirect(url_for('verify', token=endata(data)))
        else:
            flash("Email exists")
    return render_template('signup.html')


@app.route('/verify/<token>', methods=['GET','POST'])
def verify(token):
    data = dedata(token)
    if request.method == 'POST':
        if request.form['otp'] == data['otp']:
            cursor = conn.cursor()
            pwd = bcrypt.hashpw(data['password'].encode(), bcrypt.gensalt())
            cursor.execute("""
            INSERT INTO userdata(username,email,password,address,phone_no,gender)
            VALUES(%s,%s,%s,%s,%s,%s)
            """, (
                data['username'], data['email'], pwd,
                data['address'], data['phone'], data['usergender']
            ))
            conn.commit()
            return redirect(url_for('login'))
        else:
            flash("Wrong OTP")
    return render_template('otp.html')


# ---------------- LOGIN ----------------
@app.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        cursor = conn.cursor()
        cursor.execute("SELECT password FROM userdata WHERE email=%s", (request.form['email'],))
        data = cursor.fetchone()
        if data and bcrypt.checkpw(request.form['password'].encode(), data[0]):
            session['user'] = request.form['email']
            return redirect(url_for('index'))
        else:
            flash("Invalid")
    return render_template('login.html')


# ---------------- PAYMENT ----------------
@app.route('/pay/<itemid>', methods=['POST'])
def pay(itemid):
    amount = int(float(request.form['amount']) * 100)
    order = client.order.create({
        "amount": amount,
        "currency": "INR"
    })
    return render_template('pay.html', order=order)


# ---------------- LOGOUT ----------------
@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')


# ---------------- RUN ----------------
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))