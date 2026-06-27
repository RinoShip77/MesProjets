import sqlite3
import os

# La base de données sera créée à la racine du projet (au-dessus du dossier core)
DB_PATH = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'vibeflow.db')

def init_db():
    """Initialise la table des messages si elle n'existe pas."""
    with sqlite3.connect(DB_PATH) as conn:
        conn.execute('''
            CREATE TABLE IF NOT EXISTS messages (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                role TEXT NOT NULL,
                content TEXT NOT NULL,
                timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        ''')

def add_message(role: str, content: str):
    """Ajoute un message à l'historique."""
    with sqlite3.connect(DB_PATH) as conn:
        conn.execute("INSERT INTO messages (role, content) VALUES (?, ?)", (role, content))

def get_history():
    """Récupère tout l'historique."""
    with sqlite3.connect(DB_PATH) as conn:
        cur = conn.cursor()
        cur.execute("SELECT role, content FROM messages ORDER BY id ASC")
        return [{"role": row[0], "content": row[1]} for row in cur.fetchall()]

def clear_history():
    """Vide l'historique (pour le bouton Reset)."""
    with sqlite3.connect(DB_PATH) as conn:
        conn.execute("DELETE FROM messages")