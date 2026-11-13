const urlParams = {};

(window.onpopstate = function () {
    let match;
    const url = /\+/g; //'Regex' pour remplacer les signes d'addition par des espaces
    const search = /([^&=]+)=?([^&]*)/g;
    const decode = function (s) {
        return decodeURIComponent(s.replace(url, ' '));
    };
    const query = window.location.search.substring(1);

    while ((match = search.exec(query))) urlParams[decode(match[1])] = decode(match[2]);
})();

$(document).ready(() => {
    getMonster(urlParams.href); //On prend toutes les informations

    $('#btnGenerate').click(() => { //Quand on Click sur ce bouton, ...
        generateSpecimen(urlParams.href.substr((urlParams.href.indexOf("atlas/") + 6))); //On génère un nouveau spécimen
    });

    $('#btnLocation').click(() => { //Quand on click sur ce bouton, ...
        locateMonster(); //On affiche les localisations associées au monstre
    });
});

async function getMonster(url) {
    const response = await axios.get(url); //On fait une demande à Axios pour retirer de l'informations

    if(response.status === 200) {
        const monster = response.data;
        document.title = monster.name; //On change le titre du document par le nom du monstre

                                                                                                                                //On affiche:
        $('#lblIndex').text(`${monster.atlasNumber}`);                                                                          //1. le numéro
        $('#imgIcon').attr({'width': '100', 'src': monster.assets});                                                             //2. l'image du monstre
        $('#lblName').html(monster.name);                                                                                       //3. le nom
        $('#lblHealth').text(`Health: [${monster.health.min} - ${monster.health.max}]`);                                              //4. ses points de vie
        $('#lblDamage').text(`Damage: [${monster.damage.min} - ${monster.damage.max}]`);                                              //5. ses points de dommage
        $('#lblSpeed').text(`Speed: [${monster.speed.min} - ${monster.speed.max}]`);                                                 //6. ses point de vitesse
        $('#lblCritical').text(`Critical: [${(monster.critical.min*100).toFixed(2)} - ${(monster.critical.max*100).toFixed(2)}]%`);     //7. ses points de coup critique 

        displaySpecimens(monster.specimens); //Affiche ensuite les spécimens associées au monstre
    } else {
        console.log(response);
    }
}

function displaySpecimens(specimen) {
    specimen.forEach(s => { //Boucle sur le tableau
        let specimenHtml = '<tr>'; //Ouvre la balise pour ajouter une rangée

        specimenHtml += `<td><img src="img/affinities/${s.affinity}.png" title="${s.affinity}"/></td>`; //Ajoute l'image de l'affinité
        specimenHtml += `<td>${s.health}</td>`; //Ajoute la santé
        specimenHtml += `<td>${s.damage}</td>`; //Ajoute les points de dégas
        specimenHtml += `<td>${s.speed}</td>`; //Ajoute la vitesse
        specimenHtml += `<td>${(s.critical*100).toFixed(2)}%</td>`; //Ajoute les point d'attaque critique
        specimenHtml += `<td>${displayTalents(s.talents)}</td>`; //Affiche les image pour les talents 
        specimenHtml += `<td>${displayKernel(s.kernel)}</td>`; //Affiche les images des éléments
        specimenHtml += `<td class="colored-hash">${displayHash(s.hash)}</td>`; //Affiche la valeur de 'hash' du monstre selon la valeur de retour de la fonction pour formater le 'hash'
        specimenHtml += '</tr>'; //Ferme la balise pour fermer la rangée

        $('#specimens tbody').append(specimenHtml); //Ajoute la chaîne de caractères dans la partie du corps du tableau
    });
}

function displayTalents(talents) { //Va afficher les images des talents
    let talentsHtml = ''; //Déclare une chaîne de caractères locale

    for (let t = 0; t < talents.length; t++) { //Boucle qui va itérer neuf fois
        talentsHtml += `<img src="img/affinities/${talents[t]}.png" title="${talents[t]}"/>`;
    }

    return talentsHtml;
}

function displayKernel(kernel) { //Va afficher les images contenues dans le tableau de kernel
    let kernelHtml = ''; //Déclare une chaîne de caractères locale

    for (let k = 0; k < kernel.length; k++) { //Boucle qui va itérer neuf fois
        kernelHtml += `<img width="50" src="img/elements/${kernel[k]}.png" title="${kernel[k]}"/>`;
    }

    return kernelHtml;
}

function displayHash(hash) { //Va définir les couleurs selon la chaîne de caractères
    const nbGroups = 10; //Correspond au nombre de blocs de couleurs
    const groupOfCharacters = 6; //Équivaut au nombre de caractères dans un groupe
    let beginAt = 2; //Indique à quel caractère on va commencer l'extraction

    let hashHtml = hash.substr(0, beginAt); //Affiche les deux premiers caractères

    //Ajoute des blocs de couleurs selon les groupes de six caractères
    hashHtml += `<span class="block" style="color: #${hash.substr(beginAt, groupOfCharacters)}; background-color: #${hash.substr(beginAt, groupOfCharacters)}">${hash.substr(beginAt, groupOfCharacters)}</span>`;
    for (let h = 0; h < nbGroups - 1; h++) { //Boucle qui va itérer neuf fois
        beginAt += groupOfCharacters;
        hashHtml += `<span class="block" style="color: #${hash.substr(beginAt, groupOfCharacters)}; background-color: #${hash.substr(beginAt, groupOfCharacters)}">${hash.substr(beginAt, groupOfCharacters)}</span>`;
    }
    
    hashHtml += hash.substr(hash.length - 2); //Affiche les deux derniers caractères
    
    return hashHtml; //Retourne la chaîne de carctères
}

async function generateSpecimen(atlasNumber) {
    const ADD_MONSTER_URL = `https://api.andromia.science/monsters/${atlasNumber}/actions?type=generate`;
    const body = {}; //Les données du nouveau spécimen
    
    const response = await axios.post(ADD_MONSTER_URL, body); //On fait une demande de POST à Axios
    
    if(response.status === 201) { //Si ça marche, ...
        getMonster(urlParams.href); //On l'ajoute au tableau des spécimens
    } else { //Sinon, ...
        console.log(response); //On affiche la réponse
    }
}

async function locateMonster() {
    const response = await axios.get(urlParams.href); //On fait une demande à Axios pour retirer de l'informations

    if(response.status === 200) {
        const locations = response.data.locations;

        $('#location tbody').empty(); //On vide le tableau

        locations.forEach(l => {
            let locationHtml = '<tr>';                                                                                          //On va chercher:
            locationHtml += `<td id="location">${l.position}</td>`;                                                             //1. la position
            locationHtml += `<td id="location">${l.time}</td>`;                                                                 //2. le temps
            locationHtml += `<td id="location"><img width="50" src="img/seasons/${l.season}.png" title="${l.season}"/></td>`;   //3. la saison
            locationHtml += `<td id="location"><img width="50" src="img/rarities/${l.rates}.png" title="${l.rates}"/></td>`;    //4. la rareté
            locationHtml += '</tr>';
    
            $('#location tbody').append(locationHtml); //On ajoute au tableau
        });

        let addLocationHtml = '<tr>';
        
        addLocationHtml += '<td id="location"><input type="text" pattern="[A-Z]{1,2}[0-9]{3}" class="form-control" id="txtPosition"></td>'; //On ajoute un espace pour écrire la position

        addLocationHtml += '<td id="location"><select name="time" class="form-select" id="cboTime">'; //On ajoute une boîte de sélection pour ajouter le temps
        
        addLocationHtml += '<option>Morning</option>';
        addLocationHtml += '<option>Day</option>';
        addLocationHtml += '<option>Night</option>';
        addLocationHtml += '</select></td>';

        addLocationHtml += '<td id="location"><select name="season" class="form-select" id="cboSeason">'; //On ajoute un boîte de sélection por préciser la saison
        addLocationHtml += '<option>Spring</option>';
        addLocationHtml += '<option>Summer</option>';
        addLocationHtml += '<option>Autumn</option>';
        addLocationHtml += '<option>Winter</option>';
        addLocationHtml += '</select></td>';

        addLocationHtml += '<td class="d-flex" id="location"><select name="rates" class="m-2 form-select" id="cboRates">'; //On ajoute un boîte de sélection pour définir la rareté
        addLocationHtml += '<option>Common</option>';
        addLocationHtml += '<option>Uncommon</option>';
        addLocationHtml += '<option>Rare</option>';
        addLocationHtml += '<option>Limited</option>';
        addLocationHtml += '</select>';

        addLocationHtml += '<button class="m-2 btn btn-secondary" id="btnAddLocation">Add</button></td>'; //On ajoute un bouton pour ajouter un nouveau lieux d'observation
        addLocationHtml += '</tr>';

        $('#location tbody').append(addLocationHtml); //On ajoute la chaîne de caractères au tableau
    } else {
        console.log(response); //On affiche la réponse
    }

    $('#btnAddLocation').click(() => { //Le Click sur ce bouton va appeler la fonction pour ajouter une location
        addLocation();
    });
}

async function addLocation() {
    const ADD_LOCATION_URL = `${urlParams.href}/locations`;
    const body = { //Conserve les données de l'utilisateurs
        position:$('#txtPosition').val().toUpperCase(),
        time:$('#cboTime').val(),
        season:$('#cboSeason').val(),
        rates:$('#cboRates').val()
    }
    
    const response = await axios.post(ADD_LOCATION_URL, body); //On fait une demande de POST à Axios
    if(response.status === 201) { //Si ça marche, ...
        locateMonster([response.data]); //On l'ajoute aux locations connus
    } else { //Sinon, ...
        console.log(response); //On affiche la réponse
    }
}