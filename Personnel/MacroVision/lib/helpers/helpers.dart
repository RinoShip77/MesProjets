// lib/helpers/helpers.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // N'oubliez pas l'importation du package

/// Fonction utilitaire pour afficher des toasts de manière uniforme dans toute l'application.
/// 
/// @param message Le texte à afficher dans le toast.
/// @param isError Indique si le toast est un message d'erreur (fond rouge) ou un message standard (fond gris/noir).
void showAppToast(String message, {bool isError = false}) {
  
  // Définit la couleur de fond en fonction du type de message
  final Color backgroundColor = isError 
      ? Colors.red.shade700.withOpacity(0.9) // Rouge pour les erreurs
      : Colors.grey.shade700.withOpacity(0.9); // Gris foncé pour le succès/info
  
  // Définit la durée (ici, nous utilisons Toast.LENGTH_LONG pour les messages importants)
  const Toast toastLength = Toast.LENGTH_LONG;
  
  // Définit la position
  const ToastGravity gravity = ToastGravity.BOTTOM;

  // Lancement du toast
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: gravity,
    backgroundColor: backgroundColor,
    textColor: Colors.white,
    fontSize: 14.0, // Taille de police personnalisée
  );
}

// Vous pouvez ajouter d'autres fonctions utilitaires ici si nécessaire.