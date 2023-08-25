$(function(){ // Ouverture de la fonction principale
	$('#organisations').hover( // Lors du passage de la souris sur l'identifiant "organisations", ...
	function(){ // Plus précisément, lorsqu'on passe dessus avec la souris, ...
		$(this).addClass("change"); // On ajoute la classe "change"
	}, // Fermeture du bloc pour l'entrer du curseur
	function(){ // Alors que quand on sort, ...
		$(this).removeClass("change"); // On retire la classe "change"
	}); // Fermeture du bloc pour la sortie du curseur
	
	$('#ligue').hover( // Lors du passage de la souris sur l'identifiant "ligues", ...
	function(){ // Plus précisément, lorsqu'on passe dessus avec la souris, ...
		$(this).addClass("changement"); // On ajoute la classe "changement"
	}, // Fermeture du bloc pour l'entrer du curseur
	function(){ // Alors que quand on sort, ...
		$(this).removeClass("changement"); // On retire la classe "changement"
	}); // Fermeture du bloc pour la sortie du curseur
	
	var premierClick = 0; // Déclarations d'une variable locale qui vaut zéro
	$('#canada').click(function(){ // Quand on clique sur "#canada", ...
		if(premierClick == 0) // Si ma variable locale est égale à "0", ...
		{
			$('#cio').before('<hr>'); // On ajoute la balise "<hr>" (barre horizontale) avant "#cio"
			$('hr').css({"width":"100%", "border":"3px solid black"}); // On ajoute une largeur de de "100%" et une bordure noir de 3 pixels 
			premierClick=1; // On affecte la valeur "1" à la variable locale "premierClick"
		}
		
		else // Sinon, ... ( Si ma variable locale n'est pas égale à "0", ...)
		{
			$('hr').remove(); // On enléve la balise "<hr>"
			premierClick = 0; // On met ma variable locale à "0"
		}		
	}); // Fin du bloc de code pour le clique
	
	$('#description').hide(); // Cache le id="description" lors de l'ouverture de la page
	$('.bout').click(function(){ // Lorsque l'on clique une première fois sur class=".bout", ...
		$('#description').fadeToggle(); // On fait tranquillement appaître le id="description" avec un effet de fondue
		                                // et il disparait à nouvveau quand on appui de nouveau sur le bouton 
	}); // Fin du bloc de code pour le clique
	
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
	
	$('#orga').hover( // Lors du passage de la souris sur l'identifiant "ligues", ...
	function(){ // Plus précisément, lorsqu'on passe dessus avec la souris, ...
		$('#image1').attr('src','../images/imagesAthletes_1.jpg'); // On donne à l'attribut "src" la veleur "../images/imagesAthletes_1.jpg"
		$('#image2').attr('src','../images/imagesAthletes_2.png'); // On donne à l'attribut "src" la veleur "../images/imagesAthletes_.png"
	}, // Fermeture du bloc pour l'entrer du curseur
	function(){  // Alors que quand on sort, ...
		$('#image1').attr('src','../images/skyBlue.png'); // On donne à l'attribut "src" la veleur "../images/skyBlue.png"
		$('#image2').attr('src','../images/skyBlue.png'); // On donne à l'attribut "src" la veleur "../images/skyBlue.png"
	}); // Fermeture du bloc pour la sortie du curseur
}); // Fermeture de la fonction principale