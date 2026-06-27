from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from core.agent import VibeFlowAgent

# Initialisation de l'API et du noyau IA
app = FastAPI(title="VibeFlow API", description="Moteur IA centralisé", version="1.0")

# Autoriser le navigateur local à interroger l'API (CORS)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # En prod, on mettra l'URL exacte
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

agent = VibeFlowAgent()

# Modèle de données attendu par l'API
class PromptRequest(BaseModel):
    prompt: str

@app.get("/")
def read_root():
    """Vérifie si le serveur est en ligne."""
    return {"status": "VibeFlow Core Online", "agent_ready": True}

@app.post("/chat")
def chat_with_agent(request: PromptRequest):
    """Envoie une requête à l'agent et retourne sa réponse."""
    try:
        response = agent.ask(request.prompt)
        return {"response": response}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur interne de VibeFlow: {e}")