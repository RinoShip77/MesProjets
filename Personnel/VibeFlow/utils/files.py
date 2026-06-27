import os

def read_local_file(filepath: str) -> str:
    """Lit et retourne le contenu d'un fichier local."""
    if not os.path.exists(filepath):
        return f"❌ Erreur : Le fichier '{filepath}' est introuvable."
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return f.read()
    except Exception as e:
        return f"❌ Erreur lors de la lecture du fichier : {e}"