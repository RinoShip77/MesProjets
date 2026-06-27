from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import StreamingResponse
from pydantic import BaseModel
from typing import Optional
from core.agent import VibeFlowAgent

app = FastAPI(title="VibeFlow API", description="Moteur IA centralisé", version="1.1")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

agent = VibeFlowAgent()

# Ajout du champ 'model' dans la requête
class PromptRequest(BaseModel):
    prompt: str
    model: Optional[str] = "gemini-2.5-flash"

@app.get("/")
def read_root():
    return {"status": "VibeFlow Core Online"}

@app.post("/stream")
def stream_with_agent(request: PromptRequest):
    """Envoie la requête et le modèle désiré au noyau pour streaming."""
    return StreamingResponse(
        agent.stream_ask(request.prompt, request.model), 
        media_type="text/plain"
    )