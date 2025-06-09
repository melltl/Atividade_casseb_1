from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Banco de dados simulado
fake_users_db = {
    "usuario@email.com": {
        "email": "usuario@email.com",
        "hashed_password": pwd_context.hash("senha123")
    }
}


def get_user_by_email(email: str):
    return fake_users_db.get(email)
