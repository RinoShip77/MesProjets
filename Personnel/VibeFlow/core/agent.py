import os
import logging
import sys
from dotenv import load_dotenv
from google import genai
from google.api_core import exceptions as google_exceptions

# --- Configuration du Logging ---
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# --- Exceptions Customisées ---
class VibeFlowError(Exception):
    pass

class VibeFlowInitializationError(VibeFlowError):
    pass

class VibeFlowCommunicationError(VibeFlowError):
    pass

# Charger les variables d'environnement
load_dotenv()

class VibeFlowAgent:
    def __init__(self):
        """Initialise l'agent VibeFlow et sa mémoire de conversation."""
        if not os.getenv("GEMINI_API_KEY"):
            error_msg = "La variable d'environnement GEMINI_API_KEY n'est pas définie."
            logger.critical(error_msg)
            raise VibeFlowInitializationError(error_msg)

        try:
            self.client = genai.Client()
        except Exception as e:
            error_msg = f"Erreur inattendue lors de l'initialisation du client : {e}"
            logger.critical(error_msg)
            raise VibeFlowInitializationError(error_msg) from e
        
        try:
            self.chat_session = self.client.chats.create(
                model="gemini-2.5-flash",
                config={
                    "system_instruction": (
                        "Tu es VibeFlow, un assistant de développement d'élite. "
                        "Tu es direct, pragmatique et tu penses 'outside the box'. "
                        "Fournis du code propre et ne tourne jamais autour du pot."
                    )
                }
            )
        except google_exceptions.GoogleAPIError as e:
            error_msg = f"Erreur API lors de la création de la session : {e}"
            logger.critical(error_msg)
            raise VibeFlowInitializationError(error_msg) from e
        except Exception as e:
            error_msg = f"Erreur inattendue lors de la création de la session : {e}"
            logger.critical(error_msg)
            raise VibeFlowInitializationError(error_msg) from e
        
        logger.info("Agent VibeFlow initialisé avec succès.")

    def ask(self, prompt: str) -> str:
        """Envoie un message classique (attente de la réponse complète)."""
        if not hasattr(self, 'chat_session') or self.chat_session is None:
            raise VibeFlowCommunicationError("Session non initialisée.")
        try:
            response = self.chat_session.send_message(prompt)
            return response.text
        except Exception as e:
            raise VibeFlowCommunicationError(f"Erreur de communication : {e}") from e

    def stream_ask(self, prompt: str):
        """Envoie un message et génère la réponse en temps réel (streaming)."""
        if not hasattr(self, 'chat_session') or self.chat_session is None:
            yield "❌ Erreur: Session non initialisée."
            return

        try:
            # send_message_stream renvoie un itérateur de morceaux (chunks)
            response = self.chat_session.send_message_stream(prompt)
            for chunk in response:
                yield chunk.text
        except Exception as e:
            logger.error(f"Erreur lors du streaming : {e}")
            yield f"\n❌ Erreur de flux: {e}"

# --- Test direct ---
if __name__ == "__main__":
    try:
        agent = VibeFlowAgent()
        print("Agent prêt.")
    except Exception as e:
        print(f"Erreur : {e}")
        sys.exit(1)