import os
from dotenv import load_dotenv
from google import genai

# Charger la clé API du fichier .env
load_dotenv()

def test_ia():
    # Le client détecte automatiquement GEMINI_API_KEY
    client = genai.Client()
    
    print("Envoi du prompt à VibeFlow...")
    response = client.models.generate_content(
        model='gemini-2.5-flash',
        contents='Dis "VibeFlow est prêt !" en ajoutant une courte phrase motivante.',
    )
    print(f"\n[IA] : {response.text}")

if __name__ == "__main__":
    test_ia()