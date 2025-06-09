from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
#from app.auth import authenticate_user, create_access_token, get_current_user
from datetime import timedelta
from auth import authenticate_user, create_access_token, get_current_user

app = FastAPI(title="API com JWT")


@app.post("/login")
def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user = authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(status_code=400, detail="Credenciais inválidas")

    access_token = create_access_token(
        data={"sub": user["email"]},
        expires_delta=timedelta(minutes=30)
    )
    return {"access_token": access_token, "token_type": "bearer"}


@app.get("/")
def root():
    return {"mensagem": "Bem-vindo à API pública!"}


@app.get("/protected")
def protected_route(user: dict = Depends(get_current_user)):
    return {"mensagem": f"Bem-vindo, {user['email']}! Você acessou uma rota protegida."}
