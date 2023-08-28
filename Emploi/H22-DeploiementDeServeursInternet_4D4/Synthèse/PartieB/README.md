<!------------------------------------------------------------------------------------
Projet:       Projet synthèse (TP03)
Cours:        420-4D4
Fichier:      README.md
Auteur:       Olivier Bourgault
Date:         2023-05-17
Description:  Manifeste qui crée un espace de nom propre à ce projet.
              Met en place 10 déploiements d'un serveur PHP, ainsi qu'un
              service associé à un contrôlleur ingress pour y accéder
              plus rapidement. De plus, un déploiement d'une application
              NextCloud (avec une base de données), un déploiement du
              logiciel de messagerie Mattermost. L'application NextCloud
              et le ddéploiement Mattermost sont eux-aussi associés à un
              contrôlleur ingress. Les dossiers pour remplacer le fichier
              de la page d'accueil et pour assurer la conservation des
              données de Nextcloud étaient sensés être à distance (de
              type 'NFS'), mais je n'ai pas été en mesure de faire
              fonctionner le tout correctement. J'ai donc remplacer
              ceux-ci par des volumes locaux sur mon poste. Lors de ma
              remise, je fournirais également le fichier d'accueil.
------------------------------------------------------------------------------------>

1) Lors des premiers jours, j'ai simplement créer ma machine virtuelle pour pouvoir développer mon projet à partir de chez moi.
   C'est une machine sur Microsoft Azure que j'accédais par 'SSH'. Fimalement, je me suis ravisé et j'ai continuer mon projet uniquement en local.

2) J'ai ensuite renseigné le manifeste du projet:
  
  2.1) J'ai déployé un service externe de type 'loadBalancer' ainsi qu'une ressource 'ingress' pour accéder aux ressources du projet.
    2.1.1) Pour compléter le déploiement locale, il faut exécuter ces commandes avant d'appliquer le manifeste:
              - kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.9/config/manifests/metallb-native.yaml
              - kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.7.0/deploy/static/provider/cloud/deploy.yaml
    2.1.2) Il faut également renseigner le ficher 'hosts' de Windows de l'ordinateur pour rediriger les nom de domaine du projets vers l'addresse IP de votre poste.
  
  2.2) J'ai pour créé un espace de nom ('1875009-tp03') propre à ce projet et dans cette espace de nom:
    
    2.2.1) J'ai également créé un volume persistant ('nextcloud-1875009-pv') ainsi qu'un module pour récupérer son contenu ('nextcloud-1875009-pvc').
    
    2.2.2) J'ai aussi créé un module de type 'configmap' pour remplacer le ficher d'accueil du projet ('configmap-1875009').

    2.2.3) J'ai aussi créé deux modules de type 'secrets':
      2.2.3.1) Une pour renseigner les variables d'environnements de Nextcloud ('nextcloud-secrets-1875009').
      2.2.3.2) Une pour renseigner les variables d'environnements de MariaDB ('mariadb-secrets-1875009').

    2.2.4) J'ai déployé 10 instances d'un serveur PHP (tp03-deployment):
      2.2.4.1) J'y ai également associé une ressource pour configurer la page d'acceuil (voir 2.2.2).

    2.2.5) J'ai déployé une instance de l'application Nextcloud (nextcloud-deployment):
      2.2.5.1) J'y ai également associé un dossier pour assurer la conservation des données (voir 2.2.1).
      2.2.5.2) J'ai également utilisé des variables d'environnements qui provenaient d'une autre ressource (voir 2.2.3.1).

    2.2.6) J'ai déployé un service de base de données MariaDB (mariadb-deployment):
      2.2.6.1) J'ai également utilisé des variables d'environnements qui provenaient d'une autre ressource (voir 2.2.3.2).
    
    2.2.7) J'ai déployé une instance du logiciel de messagerie Mattermost (mattermost-deployment).
    
    2.2.8) J'ai également créé un service pour chaque module du projet:
      2.2.8.1) Un service pour les serveurs PHP qui servent de page d'accueil pour ce projet ('tp03-service'):
        2.2.8.1.1) J'y ai associé un nom de domaine pour y accéder plus rapidement (voir 2.2.9.1).

      2.2.8.2) Un service pour l'application Nextcloud ('nextcloud-service'):
        2.2.8.2.2) J'y ai associé un nom de domaine pour y accéder plus rapidement (voir 2.2.9.2).

      2.2.8.3) Un service pour la base de données MariaDB ('mariadb-service').

      2.2.8.4) Un service pour le logiciel Mattermost ('mattermost-service'):
        2.2.8.4.1) J'y ai associé un nom de domaine pour y accéder plus rapidement (voir 2.2.9.3).
    
    2.2.9) J'ai également créé un contrôlleur de type 'ingress' pour pouvoir accéder à certains services seulement par des nom de domaine:
      2.2.9.1) Pour accéder au serveur web, entrer 'http://accueil.tp03' dans le navigateur.
      2.2.9.2) Pour accéder à l'application Nextcloud, entrer 'http://nextcloud.tp03' dans le navigateur.
      2.2.9.3) Pour accéder au logiciel Mattermost, entrer 'http://mattermost.tp03' dans le navigateur.