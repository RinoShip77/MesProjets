import os
import time
import logging
import sys
from dotenv import load_dotenv
from google import genai
from core.database import init_db, add_message, get_history

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class VibeFlowError(Exception): pass
class VibeFlowInitializationError(VibeFlowError): pass

load_dotenv()

class VibeFlowAgent:
    def __init__(self):
        self.current_model = "gemini-2.5-flash"
        # Détection du mode développement/mock
        self.mock_mode = os.getenv("USE_MOCK_API", "False").lower() in ("true", "1", "yes")
        
        init_db() 
        
        if self.mock_mode:
            logger.info("⚠️ VibeFlow tourne en MOCK MODE. Aucun appel API ne sera facturé ou décompté.")
        else:
            if not os.getenv("GEMINI_API_KEY"):
                raise VibeFlowInitializationError("GEMINI_API_KEY manquante.")

            try:
                self.client = genai.Client()
            except Exception as e:
                raise VibeFlowInitializationError(f"Erreur d'initialisation : {e}") from e
                
            self._create_session()
            logger.info("Agent VibeFlow initialisé (Connexion API Active).")

    def _create_session(self):
        """Crée la session en injectant l'historique avec sécurité d'alternance."""
        if self.mock_mode:
            return # Pas de session Google en mode mock

        db_history = get_history()
        formatted_history = []
        
        expected_role = "user"
        for msg in db_history:
            role = "user" if msg["role"] == "user" else "model"
            
            if role == "user" and expected_role == "model":
                formatted_history.append({"role": "model", "parts": [{"text": "Erreur réseau précédente."}]})
                expected_role = "user"
            elif role == "model" and expected_role == "user":
                continue 
            
            formatted_history.append({
                "role": role,
                "parts": [{"text": msg["content"]}]
            })
            expected_role = "model" if role == "user" else "user"

        try:
            self.chat_session = self.client.chats.create(
                model=self.current_model,
                config={
                    "system_instruction": (
                        "Tu es VibeFlow, un assistant de développement d'élite. "
                        "Tu es direct, pragmatique et tu penses 'outside the box'. "
                        "Fournis du code propre et ne tourne jamais autour du pot."
                    )
                },
                history=formatted_history if formatted_history else None
            )
        except Exception as e:
            logger.error(f"Erreur fatale de session API : {e}")
            self.chat_session = None

    def stream_ask(self, prompt: str, target_model: str = "gemini-2.5-flash"):
        user_saved = False

        # --- LOGIQUE DU MODE MOCK (DÉVELOPPEMENT) ---
        if self.mock_mode:
            if not user_saved:
                add_message("user", prompt)
                user_saved = True
            
            dummy_response = (
                "Ceci est une réponse générée par le **Mock Mode** de VibeFlow. 🚀\n\n"
                "Aucun appel API n'a été effectué vers Google. Ton quota est intact. "
                "Voici un faux bloc de code pour tester l'interface :\n\n"
                "```python\n"
                "def test_interface():\n"
                "    print('Interface Web 100% opérationnelle')\n"
                "    return True\n"
                "```\n\n"
                "> N'oublie pas de repasser `USE_MOCK_API=False` dans ton `.env` pour réactiver l'IA."
            )
            
            # On simule le flux fragment par fragment avec un léger délai
            full_response = ""
            # On découpe arbitrairement pour simuler des "chunks"
            chunk_size = 4 
            for i in range(0, len(dummy_response), chunk_size):
                chunk = dummy_response[i:i+chunk_size]
                full_response += chunk
                yield chunk
                time.sleep(0.02) # Fausse latence réseau
                
            if user_saved:
                add_message("model", full_response)
            return

        # --- LOGIQUE NORMALE (PRODUCTION) ---
        if target_model != self.current_model:
            self.current_model = target_model
            self._create_session()

        if not hasattr(self, 'chat_session') or self.chat_session is None:
            yield "❌ Erreur critique : Session non initialisée."
            return

        full_response = ""

        try:
            response = self.chat_session.send_message_stream(prompt)
            
            for chunk in response:
                if not user_saved:
                    add_message("user", prompt)
                    user_saved = True
                    
                full_response += chunk.text
                yield chunk.text
            
            if user_saved:
                add_message("model", full_response)
                
        except Exception as e:
            error_str = str(e)
            logger.error(f"Erreur API capturée : {error_str}")
            
            if "429" in error_str or "ResourceExhausted" in error_str or "quota" in error_str.lower():
                yield "\n\n> ⏳ **Action requise :** Quota API atteint (5 requêtes / minute). Patiente 60 secondes avant de relancer ton message."
            else:
                yield f"\n\n> ❌ **Erreur système :** {error_str}"
            
            if user_saved:
                add_message("model", full_response + "\n\n[Interrompu par une erreur réseau]")