using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace TPSynthese
{
    /// <summary>
    /// Contient les statistiques de lecture des fichiers de données
    /// </summary>
    class StatistiquesFichiers
    {
        /// <summary>
        /// Permet d'incrémenter les différentes statistiques
        /// </summary>
        public void IncrementerAlbumsCharges() { ++_albumsCharges; }
        public void IncrementerInterpretationsChargees() { ++_interpretationsChargees; }
        public void IncrementerLignesEnErreur() { ++_lignesEnErreur; }
        public void AjouterFichierLu(string nomFichier)
        {
            _fichiersLus.Add(nomFichier);
        }
        public void AjouterFichierIntrouvable(string nomFichier)
        {
            _fichiersIntrouvables.Add(nomFichier);
        }

        /// <inheritdoc/>
        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();

            Inserer(sb, "Fichier{1} lu{1}: ", _fichiersLus.Count);
            for (int i = 0; i < _fichiersLus.Count; ++i)
            {
                if (i > 0)
                {
                    sb.Append(", ");
                }
                sb.Append(_fichiersLus[i]);
            }
            sb.Append("\n");
            Inserer(sb, "Album{1} chargé{1}\n", _albumsCharges);
            Inserer(sb, "Interprétation{1} chargée{1}\n", _interpretationsChargees);
            if (_lignesEnErreur > 0)
            {
                Inserer(sb, "Ligne{1} en erreur\n", _lignesEnErreur);
            }
            if (_fichiersIntrouvables.Count > 0)
            {
                Inserer(sb, "Fichier{1} introuvable{1}: ", _fichiersIntrouvables.Count);
                for (int i = 0; i < _fichiersIntrouvables.Count; ++i)
                {
                    if (i > 0)
                    {
                        sb.Append(", ");
                    }
                    sb.Append(_fichiersIntrouvables[i]);
                }
                sb.Append("\n");
            }

            return sb.ToString();
        }

        // Insère les valeurs données dans le string builder
        private void Inserer(StringBuilder sb, string format, int valeur)
        {
            sb.AppendFormat("{0,6} " + format, valeur, valeur > 1 ? "s" : "");
        }

        private int _albumsCharges = 0;
        private int _interpretationsChargees = 0;
        private int _lignesEnErreur = 0;
        private List<string> _fichiersLus = new List<string>();
        private List<string> _fichiersIntrouvables = new List<string>();
    }
}