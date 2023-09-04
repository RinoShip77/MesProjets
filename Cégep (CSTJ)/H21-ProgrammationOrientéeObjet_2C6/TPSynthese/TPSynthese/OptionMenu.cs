using System;
using System.Collections.Generic;
using System.Text;

namespace TPSynthese
{
    namespace Menu
    {
        /// <summary>
        /// Une option disponible dans un menu
        /// </summary>
        class OptionMenu : IEquatable<OptionMenu>
        {
            /// <summary>
            /// Constructeur
            /// </summary>
            /// <param name="choix">Le caractère associé à l'option que l'utilitateur doit indiquer pour choisir l'option.</param>
            /// <param name="description">La description de l'option. Optionnelle pour l'utilisation lors de la validation par le menu.</param>
            public OptionMenu(string choix, string description = "")
            {
                _choix = choix;
                _description = description;
            }

            /// <inheritdoc/>
            public override string ToString()
            {
                return string.Format(" {0}) {1}", _choix, _description);
            }

            /// <inheritdoc/>
            public bool Equals(OptionMenu that)
            {
                // Deux options non nulles sont égales si les choix sont égaux
                return that != null && _choix == that._choix;
            }


            private readonly string _choix;
            private readonly string _description;
        }
    }
}