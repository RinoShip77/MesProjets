$(function(){ // Ouverture de la fonction principale
	$('#description').hide(); // Cache le id="description" lors de l'ouverture de la page
	$('.bout').click(function(){ // Lorsque l'on clique une première fois sur class=".bout", ...
		$('#description').fadeToggle(); // On fait tranquillement appaître le id="description" avec un effet de fondue et il disparait à nouveau quand on appui de nouveau sur le bouton
	}); // Fin du bloc de code pour le clique
	
	$('#liste').hide(); // Cache le id="liste"
	var suggestions = ["Plus d'espace de rengement pour les effets personnels", "Avoir une section réserver aux dames pour faire leur exercices"]; // Déclaration et définition d'un tableau
	$('#sugPasse').click(function(){ // Lors du clique sur "#sugPasse", ...
		$('#liste').slideToggle(); // On affiche la liste en la déroulant
	}); // Fin du bloc du clique
	
	$('#opinion').hide(); // Cache "#opinion"
	$('.bout').click(function(){ // Quand on clique sur class=".bout", ...
		$('#opinion').css("border", "2px solid black"); // On met une bordure noir de 2 pixels sur "#opinion"
		$('#opinion').slideToggle(500); // On fait appaître le id="opinion" en le déroulant vers le bas et il remonte se cacher quand on appui de nouveau sur le bouton
	}); // Fin du bloc du clique
	$('#save').click(function(){ // Quand on clique sur #save, ...
		var nom = $('#inputNom').val(); // Récupère le contenu de la saisie et l'affecte à la variable "nom"
		var prenom = $('#inputPrenom').val(); // Récupère le contenu de la saisie et l'affecte à la variable "prenom"
		var age = $('#inputAge').val(); // Récupère le contenu de la saisie et l'affecte à la variable "mois"
		var verdictAge; // Déclarations de ma variable "vardictAge"
		var genre = $('#inputGenre').val(); // Récupère le contenu de la saisie et l'affecte à la variable "genre"
		var sugg1 = $('#inputSug1').val(); // Récupère le contenu de la saisie et l'affecte à la variable "sugg1"
		var sugg2 = $('#inputSug2').val(); // Récupère le contenu de la saisie et l'affecte à la variable "sugg2"
		if(nom == "" || prenom == "") // Si aucun nom ou prénom n'est saisie, ...
		{
			alert("Vous devez obiglatoirement saisir un nom ET un prénom"); // Affiche un message à l'utilisateur
			$('#inputNom').focus(); // Place le curseur dans le champ de saisie du nom
			$('#inputPrenom').focus(); // Place le curseur dans le champ de saisie du prénom
		}
		else // Sinon, ... (Si un nom ou prénom est saisie, ...)
		{
			if(age <= 15) // Si l'âge saisie est inférieur à 15, ...
			{
				verdictAge = "vous êtes trop jeune"; // Affecte "vous êtes trop jeune" à "vardictAge"
			}
			else // Sinon, ... (Si l'âge saisie n'est pas inférieur à 15, ...)
			{
				if(age >= 16 && age <= 18) // Si l'âge saisie est supérieur ou égale à 16 et inférieur ou égale à 18, ...
				{
					verdictAge = "vous devez revenir après 2 ans"; // Affecte "vous devez revenir après 2 ans" à "vardictAge"
				}	
				else // Sinon, ... (Si l'âge saisie n'est pas supérieur ou égale à 16 et inférieur ou égale à 18, ...)
				{
					if(age > 18) // Si l'âge est supérieur à 18, ...
					{
						verdictAge = "pour vos suggestions"; // Affecte "pour vos suggestions" à "vardictAge"
						$('#save').addClass("btn btn-success"); // Ajoute la classe "btn" et "btn-success" au bouton enregistrer
					}	
					else // Sinon, ... (// Si l'âge n'est pas supérieur à 18, ...)
					{
						alert("Vous devez saisir votre âge.") // Affiche un message à l'utilisateur
						$('#inputAge').focus(); // Place le curseur dans le champ de saisie de l'âge
					} // Fin du bloc (age > 18)
				} // Fin du bloc (age >= 16 && age <= 18)
			} // Fin du bloc (age < 15)
		} // Fin du bloc (nom == "" || prenom == "")
		if(genre == 'M' || genre == 'm') // Si le genre est masculin, ...
		{
			alert("Merci, monsieur " + nom + " " + verdictAge + "."); // Affiche un message à l'utilisateur
			$('.input').val(""); // Vide les saisies
			$('#opinion').slideUp(); // Cache le bloc #opinion
			$('#save').removeClass("btn btn-success"); // Enlève la classe "btn" et "btn-success" au bouton
			suggestions.push(sugg1); // Ajoute la variable "sugg1" au tableau "suggestions"
			$('ul').append('<li>'+ sugg1 +'</li>'); // Ajoute "sugg1" à la liste "ul"
			$('#inputSug1').val(""); // Vide la saisie
			suggestions.push(sugg2); // Ajoute la variable "sugg2" au tableau "suggestions"
			$('ul').append('<li>'+ sugg2 +'</li>'); // Ajoute "sugg2" à la liste "ul"
			$('#inputSug2').val(""); // Vide la saisie
		}
		else // Sinon, ... (Si le genre n'est pas masculin, ...)
		{
			if(genre == 'F' || genre == 'f') // Si le genre est féminin, ...
			{
				alert("Merci, madame " + nom + " " + verdictAge + "."); // Affiche un message à l'utilisateur
				$('.input').val("");// Vide les saisies
				$('#opinion').slideUp(); // Cache le bloc #opinion
				$('#save').removeClass("btn btn-success"); // Enlève la classe "btn" et "btn-success" au bouton
				suggestions.push(sugg1); // Ajoute la variable "sugg1" au tableau "suggestions"
				$('ul').append('<li>'+ sugg1 +'</li>'); // Ajoute "sugg1" à la liste "ul"
				$('#inputSug1').val(""); // Vide la saisie
				suggestions.push(sugg2); // Ajoute la variable "sugg2" au tableau "suggestions"
				$('ul').append('<li>'+ sugg2 +'</li>'); // Ajoute "sugg2" à la liste "ul"
				$('#inputSug2').val(""); // Vide la saisie
			} // Fin du bloc (genre == 'F' || genre == 'f')
		} // Fin du bloc (genre == 'M' || genre == 'm')
	}); // Fin du bloc du clique
	$('#cancel').click(function(){ // Lorsqu'on clique sur "#cancel", ...
		$('.input').val(""); // On réinitialise les class="input"
	}); // Fin du bloc du clique
	
	$('#carte').hide(); // Cache le id="carte" lors de l'ouverture de la page
	$('#texte').css("padding-top", "25%"); // Donne 25% à la valeur de la marge intérieur avec la propriété CSS 
	$('#texte').dblclick(function(){ // Lorsque l'on double clique la première fois sur id="texte", ...
		$(this).hide(function(){ // On cache le id="texte". Une fois finis, ...
			$('#carte').show(); // On montre le id="carte"
		}); // Fin du bloc pour cacher le texte puis afficher l'image
	
		$('#carte').click(function(){ // Lorsque l'on clique une première fois sur id="carte", ...
			$(this).fadeOut(function(){ // On fait tranquillement disparaître le id="carte" avec un effet de fondue. Une fois terminé, ...
				$('#texte').slideDown(); // On fait tranquillement descendre le id="texte"
			}); // Fin du bloc pour cacher l'image puis faire dérouler le texte
		}); // Fin du bloc de code pour le clique
	}); // Fin du bloc pour le double clique
}); // Fermeture de la fonction principale