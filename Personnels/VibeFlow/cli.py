import sys
from core.agent import VibeFlowAgent
from utils.files import read_local_file

def main():
    print("⚡ VibeFlow CLI - Démarrage du noyau...")
    agent = VibeFlowAgent()
    print("✅ VibeFlow est en ligne. Prêt à coder.")
    print("💡 Commandes :")
    print("   /read <fichier> <question> : Analyse un fichier local")
    print("   exit ou quit               : Fermer la session\n")
    print("-" * 50)

    while True:
        try:
            user_input = input("\n[Olivier] > ")
            
            if user_input.lower() in ['exit', 'quit']:
                print("\n[VibeFlow] > Déconnexion. À plus tard !")
                sys.exit(0)
            
            if not user_input.strip():
                continue

            # --- INTERCEPTION DES COMMANDES DE FICHIERS ---
            if user_input.startswith("/read "):
                # Sépare la commande en 3 parties max: "/read", "nom_fichier", "le reste de la question"
                parts = user_input.split(" ", 2)
                if len(parts) < 2:
                    print("[Système] > Usage correct: /read <fichier> <question optionnelle>")
                    continue
                
                filepath = parts[1]
                extra_prompt = parts[2] if len(parts) > 2 else "Analyse ce code et explique-moi ce qu'il fait."
                
                print(f"[Système] > Lecture de {filepath}...")
                file_content = read_local_file(filepath)
                
                # Si le fichier n'existe pas, on arrête là et on redemande un input
                if file_content.startswith("❌"):
                    print(file_content)
                    continue
                    
                # On prépare le super-prompt pour l'IA
                print("[VibeFlow] > Analyse en cours...")
                user_input = f"Voici le contenu du fichier {filepath} :\n```\n{file_content}\n```\nInstruction : {extra_prompt}"
            else:
                print("[VibeFlow] > ...")

            # --- ENVOI À L'AGENT ---
            response = agent.ask(user_input)
            print(f"[VibeFlow] > {response}")

        except KeyboardInterrupt:
            # Gère proprement le CTRL+C
            print("\n\n[VibeFlow] > Arrêt d'urgence. Ciao !")
            sys.exit(0)
        except Exception as e:
            print(f"\n[Système] > Erreur inattendue : {e}")

if __name__ == "__main__":
    main()