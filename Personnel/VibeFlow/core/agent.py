import os
import logging
import sys
from dotenv import load_dotenv
from google import genai
from google.api_core import exceptions as google_exceptions

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class VibeFlowError(Exception): pass
class VibeFlowInitializationError(VibeFlowError): pass
class VibeFlowCommunicationError(VibeFlowError): pass

load_dotenv()

class VibeFlowAgent:
    def __init__(self):
        """Initialise l'agent avec le modèle par défaut (Flash)."""
        self.current_model = "gemini-2.5-flash"
        
        if not os.getenv("GEMINI_API_KEY"):
            error_msg = "La variable d'environnement GEMINI_API_KEY n'est pas définie."
            logger.critical(error_msg)
            raise VibeFlowInitializationError(error_msg)

        try:
            self.client = genai.Client()
        except Exception as e:
            raise VibeFlowInitializationError(f"Erreur d'initialisation client : {e}") from e
            
        self._create_session()
        logger.info("Agent VibeFlow initialisé avec succès.")

    def _create_session(self):
        """Crée (ou recrée) la session de chat avec le modèle actif."""
        try:
            self.chat_session = self.client.chats.create(
                model=self.current_model,
                config={
                    "system_instruction": (
                        "Tu es VibeFlow, un assistant de développement d'élite. "
                        "Tu es direct, pragmatique et tu penses 'outside the box'. "
                        "Fournis du code propre et ne tourne jamais autour du pot."
                    )
                }
            )
        except Exception as e:
            raise VibeFlowInitializationError(f"Erreur de création de session : {e}") from e

    def stream_ask(self, prompt: str, target_model: str = "gemini-2.5-flash"):
        """Envoie un message en streaming. Change de modèle si nécessaire."""
        
        # Basculement de modèle (Swap de cerveau)
        if target_model != self.current_model:
            logger.info(f"🔄 Basculement de modèle : {self.current_model} -> {target_model}")
            self.current_model = target_model
            self._create_session() # On réinitialise la session avec le nouveau modèle

        if not hasattr(self, 'chat_session') or self.chat_session is None:
            yield "❌ Erreur: Session non initialisée."
            return

        try:
            response = self.chat_session.send_message_stream(prompt)
            for chunk in response:
                yield chunk.text
        except Exception as e:
            logger.error(f"Erreur lors du streaming : {e}")
            yield f"\n❌ Erreur de flux: {e}"