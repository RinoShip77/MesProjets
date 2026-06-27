import os
from dotenv import load_dotenv
from google import genai

# Charger les variables d'environnement
load_dotenv()

class VibeFlowAgent:
    def __init__(self):
        """Initialise l'agent VibeFlow et sa mémoire de conversation."""
        self.client = genai.Client()
        
        # On utilise chats.create pour maintenir l'historique automatiquement
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

    def ask(self, prompt: str) -> str:
        """Envoie un message à l'IA et retourne sa réponse tout en gardant le contexte."""
        try:
            response = self.chat_session.send_message(prompt)
            return response.text
        except Exception as e:
            return f"❌ Erreur système : {e}"

# Petit test rapide si on exécute ce fichier directement
if __name__ == "__main__":
    agent = VibeFlowAgent()
    print("Agent initialisé. Test de la mémoire...")
    print("User: Mon nom est Olivier.")
    agent.ask("Mon nom est Olivier.")
    
    reponse = agent.ask("Comment je m'appelle ?")
    print(f"VibeFlow: {reponse}")