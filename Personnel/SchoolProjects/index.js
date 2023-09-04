let cpt;

function chargementComplete() {
    cpt = setTimeout(afficherPage, 3000);
}

function afficherPage() {
    $(".chargeur").fadeOut();
    document.getElementById("monContenu").style.display = "block";
}

$(document).ready(function () {
    $("#btnSessionA20").hide();
    $("#lstA20").hide();
    $('#annee1').click(function () {
        $("#lstA20").hide();
        $("#btnSessionA20").slideToggle();
    });
    $("#btnSessionA20").click(function () {
        $("#lstA20").slideToggle();
        $("#btnInterfaceWebA20").click(function () {
            $("#lstInterfaceWebA20").slideToggle();
            $("#lstInterfaceWebA20").click(function () {
                $("#btnPowerFitness").slideToggle();
            });
        });
    });

    $("#btnSessionH21").hide();
    $("#lstH21").hide();
    $('#annee1').click(function () {
        $("#lstH21").hide();
        $("#btnSessionH21").slideToggle();
    });
    $("#btnSessionH21").click(function () {
        $("#lstH21").slideToggle();
    });

    $("#btnSessionA21").hide();
    $("#lstA21").hide();
    $('#annee2').click(function () {
        $("#lstA21").hide();
        $("#btnSessionA21").slideToggle();
    });
    $("#btnSessionA21").click(function () {
        $("#lstA21").slideToggle();
        $("#btnTechnologieWebA21").click(function () {
            $("#lstTechnologieWebA21").slideToggle();
            $("#lstTechnologieWebA21").click(function () {
                $("#btnAccueilA21").slideToggle();
                $("#btnPokerA21").slideToggle();
                $("#btnJourvieA21").slideToggle();
                $("#btnSyntheseA21").slideToggle();
            });
        });
    });

    $("#btnSessionH22").hide();
    $("#lstH22").hide();
    $('#annee2').click(function () {
        $("#lstH22").hide();
        $("#btnSessionH22").slideToggle();
    });
    $("#btnSessionH22").click(function () {
        $("#lstH22").slideToggle();
    });

    $("#btnSessionA22").hide();
    $("#lstA22").hide();
    $('#annee3').click(function () {
        $("#lstA22").hide();
        $("#btnSessionA22").slideToggle();
    });
    $("#btnSessionA22").click(function () {
        $("#lstA22").slideToggle();
        $("#btnTechnologieWebA22").click(function () {
            $("#lstTechnologieWebA22").slideToggle();
            $("#lstTechnologieWebA22").click(function () {
                $("#btnAccueilA22").slideToggle();
                $("#btnSphinxA22").slideToggle();
                $("#btnJourvieA22").slideToggle();
                $("#btnTP1CitationA22").slideToggle();
                $("#btnTP2ConvertoA22").slideToggle();
                $("#btnTP3JourvieSyntheseA22").slideToggle();
                $("#btnExamenFormatifA22").slideToggle();
                $("#btnExamenSommatifA22").slideToggle();
            });
        });
    });

    $("#btnSessionH23").hide();
    $("#lstH23").hide();
    $('#annee3').click(function () {
        $("#lstH23").hide();
        $("#btnSessionH23").slideToggle();
    });
    $("#btnSessionH23").click(function () {
        $("#lstH23").slideToggle();
        $("#btnDeploiementServeursH23").click(function () {
            $("#lstDeploiementServeursH23").slideToggle();
            $("#lstDeploiementServeursH23").click(function () {
                $("#btnServeursTP01H23").slideToggle();
                $("#btnServeursTP02H23").slideToggle();
                $("#btnServeursTPESH23").slideToggle();
            });
        });
        $("#btnDeveloppementWebH23").click(function () {
            $("#lstDeveloppementWebH23").slideToggle();
            $("#lstDeveloppementWebH23").click(function () {
                $("#btnDeveloppementTP01H23").slideToggle();
                $("#btnDeveloppementTP02H23").slideToggle();
                $("#btnDeveloppementTP03H23").slideToggle();
                $("#btnDeveloppementTP04H23").slideToggle();
                $("#btnDeveloppementTPESH23").slideToggle();
            });
        });
    });

    $("#btnSessionA23").hide();
    $("#lstA23").hide();
    $('#annee4').click(function () {
        $("#lstA23").hide();
        $("#btnSessionA23").slideToggle();
    });
    $("#btnSessionA23").click(function () {
        $("#lstA23").slideToggle();
        $("#btnProjetDeDeveloppementA23").click(function () {
            $("#lstProjetDeDeveloppementA23").slideToggle();
            $("#lstProjetDeDeveloppementA23").click(function () {
                $("#btnProjetTP09A23").slideToggle();
                $("#btnProjetA23").slideToggle();
            });
        });
        $("#btnSecuriteDesDonneesA23").click(function () {
            $("#lstSecuriteDesDonneesA23").slideToggle();
            $("#lstSecuriteDesDonneesA23").click(function () {
                $("#btnSecuriteA23").slideToggle();
            });
        });
        $("#btnSystemesMulticlientsA23").click(function () {
            $("#lstSystemesMulticlientsA23").slideToggle();
            $("#lstSystemesMulticlientsA23").click(function () {
                $("#btnSystemesA23").slideToggle();
                $("#btnSystemesA23").click(function () {
                    $('#lstVersionA23').slideToggle();
                    $('#lstVersionA23').click(function () {
                        $("#btnVersionWebA23").slideToggle();
                        $("#btnVersionAndroidA23").slideToggle();
                    });
                });
            });
        });
    });

    $("#btnSessionH24").hide();
    $("#lstH24").hide();
    $('#annee4').click(function () {
        $("#lstH24").hide();
        $("#btnSessionH24").slideToggle();
    });
    $("#btnSessionH24").click(function () {
        $("#lstH24").slideToggle();
    });
});