# Fichier de départ pour le 'build' de l'application wordpress

FROM wordpress
ENV WORDPRESS_TABLE_PREFIX=1875009_
WORKDIR /var/www/html/
RUN apt update && apt install wget unzip
RUN wget https://downloads.wordpress.org/theme/simple-style.1.1.12.zip && unzip simple-style.1.1.12.zip
RUN cp -r simple-style /usr/src/wordpress/wp-content/themes/
RUN wget https://downloads.wordpress.org/plugin/code-prettify.zip && unzip code-prettify
RUN cp -r code-prettify /usr/src/wordpress/wp-content/plugins/