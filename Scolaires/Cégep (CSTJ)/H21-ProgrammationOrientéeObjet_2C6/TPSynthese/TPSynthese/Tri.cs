namespace TPSynthese
{
    /// <summary>
    /// Cette classe est représente le type de tri utilisé dans l'affichage des
    /// listes: alphabétique ou inverse
    /// </summary>
    class Tri
    {
        /// <summary>
        /// Indique le type de tri
        /// </summary>
        public bool EstAZ { get { return _alpha; } }
        public bool EstZA { get { return !_alpha; } }

        /// <summary>
        /// Modifie le type de tri
        /// </summary>
        public void SetAZ() { _alpha = true; }
        public void SetZA() { _alpha = false; }

        /// <inheritdoc/>
        public override string ToString()
        {
            return _alpha ? "A à Z" : "Z à A";
        }


        private bool _alpha = true;  // Par défaut, le tri est alphabétique
    }
}