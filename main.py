from fastapi import FastAPI

app = FastAPI(title="Minha API", description="Exemplo de API com Swagger", version="1.0")

@app.get("/")
def read_root():
    return {"mensagem": "Bem-vindo à minha API!"}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "query": q}
