from itsdangerous import URLSafeTimedSerializer
salt='OTPverifyadmin'
secret_key='zoro@123'
def endata(data):
    serializer=URLSafeTimedSerializer(secret_key)
    return serializer.dumps(data,salt=salt)
def dedata(data):
    serializer=URLSafeTimedSerializer(secret_key)
    return serializer.loads(data,salt=salt,max_age=60)