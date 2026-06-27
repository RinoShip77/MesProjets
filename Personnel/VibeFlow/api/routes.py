from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import StreamingResponse
from pydantic import BaseModel
from core.agent import VibeFlowAgent

app = FastAPI(title="VibeFlow API", description="Moteur IA centralisé", version="1.0")

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

@app.get("/")
def read_root():
    return {"status": "VibeFlow Core Online"}

@app.post("/chat")
def chat_with_agent(request: PromptRequest):
    """Ancienne route : attend la réponse complète."""
    try:
        response = agent.ask(request.prompt)
        return {"response": response}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/stream")
def stream_with_agent(request: PromptRequest):
    """Nouvelle route : renvoie la réponse en temps réel."""
    return StreamingResponse(agent.stream_ask(request.prompt), media_type="text/plain")