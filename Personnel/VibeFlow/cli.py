import sys
from core.agent import VibeFlowAgent

def main():
    print("⚡ VibeFlow CLI - Démarrage du noyau...")
    agent = VibeFlowAgent()
    print("✅ VibeFlow est en ligne. Prêt à coder.")
    print("💡 (Tape 'exit' ou 'quit' pour fermer la session)\n")
    print("-" * 50)

    while True:
        try:
            # L'input attend ta commande
            user_input = input("\n[Olivier] > ")
            
            # Condition de sortie
            if user_input.lower() in ['exit', 'quit']:
                print("\n[VibeFlow] > Déconnexion. À plus tard !")
                sys.exit(0)
            
            # Ignorer les entrées vides
            if not user_input.strip():
                continue

            # Appel à l'agent
            print("[VibeFlow] > ...")
            response = agent.ask(user_input)
            
            # Affichage de la réponse
            print(f"[VibeFlow] > {response}")

        except KeyboardInterrupt:
            # Gère proprement le CTRL+C
            print("\n\n[VibeFlow] > Arrêt d'urgence. Ciao !")
            sys.exit(0)
        except Exception as e:
            print(f"\n[Système] > Erreur inattendue : {e}")

if __name__ == "__main__":
    main()