$(function(){ // Ouverture de la fonction principale
	$('#description').hide(); // Cache le id="description" lors de l'ouverture de la page
	$('.bout').click(function(){ // Lorsque l'on clique une première fois sur class=".bout", ...
		$('#description').fadeToggle(); // On fait tranquillement appaître le id="description" avec un effet de fondue et il disparait à nouvveau quand on appui de nouveau sur le bouton 
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
}); // Fermeture de la fonction principale