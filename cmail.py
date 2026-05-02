import os
import smtplib
from email.message import EmailMessage

def send_mail(to, subject, body):
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    
    server.login(
        os.getenv("EMAIL"),
        os.getenv("EMAIL_PASSWORD")
    )

    msg = EmailMessage()
    msg['FROM'] = os.getenv("EMAIL")
    msg['TO'] = to
    msg['SUBJECT'] = subject
    msg.set_content(body)

    server.send_message(msg)
    server.close()