from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import StreamingResponse
from pydantic import BaseModel
from typing import Optional
from core.agent import VibeFlowAgent
from core.database import get_history, clear_history

app = FastAPI(title="VibeFlow API", description="Moteur IA centralisé", version="1.3")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

agent = VibeFlowAgent()

class PromptRequest(BaseModel):
    prompt: str
    model: Optional[str] = "gemini-2.5-flash"

@app.get("/")
def read_root():
    return {"status": "VibeFlow Core Online"}

@app.get("/history")
def fetch_history():
    """Renvoie l'historique SQLite ET l'état du Mock Mode pour le navigateur."""
    return {
        "history": get_history(),
        "mock_mode": getattr(agent, 'mock_mode', False)
    }

@app.post("/clear")
def wipe_history():
    """Efface la BDD et réinitialise la RAM de l'agent."""
    clear_history()
    agent._create_session()
    return {"status": "success"}

@app.post("/stream")
def stream_with_agent(request: PromptRequest):
    return StreamingResponse(
        agent.stream_ask(request.prompt, request.model), 
        media_type="text/plain"
    )