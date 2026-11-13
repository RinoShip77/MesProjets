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
    """Exception de base pour les erreurs de l'agent VibeFlow."""
    pass

class VibeFlowInitializationError(VibeFlowError):
    """Exception levée lors d'erreurs d'initialisation de l'agent."""
    pass

class VibeFlowCommunicationError(VibeFlowError):
    """Exception levée lors d'erreurs de communication avec le modèle IA."""
    pass

# Charger les variables d'environnement depuis .env
load_dotenv()

class VibeFlowAgent:
    def __init__(self):
        """Initialise l'agent VibeFlow et sa mémoire de conversation."""
        # 1. Vérification de la clé API
        if not os.getenv("GEMINI_API_KEY"):
            error_msg = "La variable d'environnement GEMINI_API_KEY n'est pas définie. " \
                        "Veuillez la configurer dans votre fichier .env."
            logger.critical(error_msg)
            raise VibeFlowInitializationError(error_msg)

        try:
            # 2. Initialisation du client GenAI
            self.client = genai.Client()
        except Exception as e:
            error_msg = f"Erreur inattendue lors de l'initialisation du client Google GenAI : {e}"
            logger.critical(error_msg)
            raise VibeFlowInitializationError(error_msg) from e
        
        try:
            # 3. Création de la session de chat
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
            error_msg = f"Erreur API lors de la création de la session de chat : {e}"
            logger.critical(error_msg)
            raise VibeFlowInitializationError(error_msg) from e
        except Exception as e:
            error_msg = f"Erreur inattendue lors de la création de la session de chat : {e}"
            logger.critical(error_msg)
            raise VibeFlowInitializationError(error_msg) from e
        
        logger.info("Agent VibeFlow initialisé avec succès.")

    def ask(self, prompt: str) -> str:
        """Envoie un message à l'IA et retourne sa réponse tout en gardant le contexte."""
        if not hasattr(self, 'chat_session') or self.chat_session is None:
            error_msg = "La session de chat VibeFlow n'est pas initialisée."
            logger.error(error_msg)
            raise VibeFlowCommunicationError(error_msg)

        try:
            response = self.chat_session.send_message(prompt)
            return response.text
        except google_exceptions.GoogleAPIError as e:
            error_msg = f"Erreur API lors de l'envoi du message : {e}"
            logger.error(error_msg)
            raise VibeFlowCommunicationError(error_msg) from e
        except Exception as e:
            error_msg = f"Erreur inattendue lors de la communication : {e}"
            logger.error(error_msg)
            raise VibeFlowCommunicationError(error_msg) from e

# --- Test direct du module ---
if __name__ == "__main__":
    agent = None
    try:
        agent = VibeFlowAgent()
        logger.info("Test de la mémoire en cours...")
        
        try:
            agent.ask("Mon nom est Oliviervier.")
            reponse = agent.ask("Comment je m'appelle ?")
            print(f"VibeFlow: {reponse}")
        except VibeFlowCommunicationError as e:
            print(f"🟠 Erreur de communication VibeFlow : {e}")
            sys.exit(1)

    except VibeFlowInitializationError as e:
        print(f"🔴 Erreur fatale à l'initialisation : {e}")
        sys.exit(1)
    except Exception as e:
        print(f"❌ Erreur inattendue : {e}")
        sys.exit(1)