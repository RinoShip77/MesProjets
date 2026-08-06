FROM node:22-alpine
WORKDIR /app
# L'astérisque permet de copier package.json ET package-lock.json en une seule ligne
COPY package*.json ./
RUN npm ci
# On copie tout le reste (le .dockerignore bloque ce qu'il ne faut pas copier)
COPY . .
EXPOSE 3000
CMD ["npm", "start"]