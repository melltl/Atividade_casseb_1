from fastapi.testclient import TestClient
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app.main import app


client = TestClient(app)


def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"mensagem": "Bem-vindo à minha API!"}


def test_read_item():
    response = client.get("/items/42?q=teste")
    assert response.status_code == 200
    assert response.json() == {"item_id": 42, "query": "teste"}
