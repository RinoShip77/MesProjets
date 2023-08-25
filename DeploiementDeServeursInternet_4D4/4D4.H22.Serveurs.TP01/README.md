1) Renseigner le fichier docker-compose.yml et le fichier .env, ainsi que créer de réseaux privés 'reseauWP' et 'reseauPMM'.

	1.2) Pour le réseau privé 'reseauWP':

		1.2.1) Renseigner la source des images, mon nom ainsi que les liens dans le fichier index.html du serveur web. Avoir un serveur web NGINX fait avec
		       le contenu du dossier "contenu-web" sur le port 80 (accessible via 'localhost' dans un fureteur). Celui-ci
			   permettra de naviguer entre les différents services de l'application.

		1.2.2) Par la suite, j'ai ajouté une base de données de type MariaDB accessible sur le port 3307 et qui écoute sur le 3306. De plus, j'ai assuré la
			   sauvegarde locale des données des bases de données dans le dossier locale "bdwp".

		1.2.3) J'ai ensuite rencontré une embûche pour mon installation de mon site Wordpress, je recevais le message "Error establishing a database connection".
			   Donc, je me suis assuré que les variables d'environnements (soit le nom d'utilisateur ansi que le mot de passe) de Wordpress correspondaient à
			   celles de la base de données. Il y avait effectivement une différence dans la mot de passe. J'ai donc corrigé ceci et mon site Wordpress était
			   maintenant disponible sur le port 88, via le serveur web NGINX en cliquant sur l'image de Wordpress. 
			   2.3.1) Pour la configuration de Wordpress, j'ai du renseigner un champ "build: " dans le fichier 'docker-compose.yml' pour personnalisée celle-ci. Ainsi,
					  j'ai commencé par renseigné le ficher 'Dockerfile' pour le site. Ensuite, j'ai renseigné le préfixe des tables de la base de données. Je suis
					  donc passé de 'wp_' à 'monMatricule_'. J'ai ensuite assuré l'installation du thème 'simple-style' et du plugin 'code-prettify'.

		1.2.4) Pour finir avec ce réseau, j'ai ajouté le service 'phpMyAdmin' sur le port 82 et qui permettra de visualiser la base de données MariaDB.

	1.3) Pour le réseau privé 'reseauPMM':
	
		1.3.1) Un service de base de données de type PostgrSQL qui est sur le port 5432.

		1.3.2) Un service 'Percona Monitoring and Management' qui va nous aider à gérer le service 'PostgreSQL', accessible via 'localhost:83'. L'accès de ce service
			   est admin:admin.

		1.3.3) Un service pour obtenir des statistiques d'utilisation du SGBD via l'application 'percona PMM Server'. Ce service va aider à visualiser ces données.

		1.3.4) Un service 'postgresAdmin' pour nous permettre de visualiser la base de données PostgreSQL. Celui-ci est accessible sur le poirt 81.
