const SERVICE_URL = 'https://api.andromia.science/monsters/atlas';

$(document).ready(() => { //Va exécuter la fonction quand le document sera chargé
    getMonsters();
});

async function getMonsters() { //Fonction pour récupérer les monstres
    const response = await axios.get(SERVICE_URL); //On demande les informations des monstres

    if(response.status === 200) {
        const monstres = response.data; //On conserve la réponse (les informations) dans une constante locale
            
        monstres.forEach(m => {
            $('#Monsters').append(displayMonster(m)); //Ajoute les monstres au tableau
        });
    } else {
        console.log(erreur); //Affiche l'erreur
    }
}

function displayMonster(monster) {
    let monsterHtml = '<tr>';  //Ajoute une balise de rangée

    monsterHtml += `<td><b>${monster.atlasNumber}</b>\n<img width="100" src="${monster.assets}"/></td>`; //Ajoute le numéro du monstre ainsi que l'image de celui-ci
    monsterHtml += `<td><a href="./details.html?href=${SERVICE_URL}/${monster.atlasNumber}">${monster.name}</a></td>`; //Ajoute le nom du monstre sous forme de lien qui mène vers les détails de spécimen
    monsterHtml += `<td>[${monster.health.min} - ${monster.health.max}]</td>`; //Formate et affiche les points de vie
    monsterHtml += `<td>[${monster.damage.min} - ${monster.damage.max}]</td>`; //Récupère et met les points de dégats dans le bon ordre
    monsterHtml += `<td>[${monster.speed.min} - ${monster.speed.max}]</td>`; //Affiche les points de vitesse comme il le faut
    monsterHtml += `<td>[${(monster.critical.min*100).toFixed(2)} - ${(monster.critical.max*100).toFixed(2)}]%</td>`; //Prend les points de critique et les mets dans le bon formats
    monsterHtml += '</tr>'; //Ferme la balise pour la rangée
    
    return monsterHtml; //Retourne la chaîne de caractères
}