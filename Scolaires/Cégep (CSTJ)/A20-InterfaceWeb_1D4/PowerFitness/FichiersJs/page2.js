$(function(){ // Ouverture de la fonction principale
	$('#listePlan').hover( // Lors du passage de la souris sur l'identifiant "listePlan", ...
	function(){ // Plus précisément, lorsqu'on passe dessus avec la souris, ...
		$(this).addClass("passage1"); // On ajoute la classe "passage1"
	}, // Fermeture du bloc pour l'entrer du curseur
	function(){ // Alors que quand on sort, ...
		$(this).removeClass("passage1"); // On retire la classe "passage1"
	}); // Fermeture du bloc pour la sortie du curseur
	
	$('#coach').hover( // Lors du passage de la souris sur l'identifiant "coach", ...
	function(){// Plus précisément, lorsqu'on passe dessus avec la souris, ...
		$(this).addClass("passage2"); // On ajoute la classe "passage2"
	}, // Fermeture du bloc pour l'entrer du curseur
	function(){ // Alors que quand on sort, ...
		$(this).removeClass("passage2"); // On retire la classe "passage2"
	}); // Fermeture du bloc pour la sortie du curseur
	
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
	
	$('#services').hover( // Lors du passage de la souris sur l'identifiant "services", ...
	function(){ // Plus précisément, lorsqu'on passe dessus avec la souris, ...
		$('#surplus').text("Surplus disponibles (avec toutes les offres):"); // Modifie le text pour "Surplus disponibles (avec toutes les offres):"
		$('#surplus').css("font-weight", "bold"); // Donne la propriété CSS pour que le texte soit en gras
	}, // Fermeture du bloc pour l'entrer du curseur
	function(){ // Alors que quand on sort, ...
		$('#surplus').text("Surplus disponibles"); // Modifie le text pour "Surplus disponibles"
		$('#surplus').css("font-weight", "bold"); // Donne la propriété CSS pour que le texte soit en gras
	}); // Fermeture du bloc pour la sortie du curseur
}); // Fermeture de la fonction principale