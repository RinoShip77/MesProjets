<template>
    <InitialLayout>
        <header class="bg-danger bg-opacity-75 d-flex justify-content-center">
            <div>
                <img :src="`logo.ico`" alt="Kaomia" title="Kaomia" class="img-fluid" width="125">
                <h1 class="ms-2 navTitle">Kaomia</h1>
            </div>
        </header>
        <div class="container">
            <div class="row">

                <h2 class="text-center mx-2 my-2 mt-5">Création de compte</h2>
                <div class="d-flex justify-content-center">
                    <div class="col-4 mx-2 my-2">
                        <form class="form">
                            <label for="email" class="form-label">Adresse courrielle</label>
                            <input v-model="email" type="email" class="form-control" name="email" required>
                            <label for="username" class="form-label">Nom d'utilisateur</label>
                            <input v-model="username" type="text" class="form-control" name="username" required>
                            <label for="name" class="form-label">Prénom</label>
                            <input v-model="name" type="text" class="form-control" name="name" required>
                            <label for="surname" class="form-label">Nom</label>
                            <input v-model="surname" type="text" class="form-control" name="surname" required>
                            <label for="password" class="form-label">Mot de passe</label>
                            <input v-model="password" type="password" class="form-control" name="password" required>
                            <label for="repeatpassword" class="form-label">Veuillez reinscrire votre mot de passe</label>
                            <input v-model="repeatPassword" type="password" class="form-control" name="repeatpassword"
                                required>
                            <button class="form-control btn btn-primary my-4" @click="createAccount">Créer un
                                compte</button>

                        </form>
                        <ErrorModal v-if="showError" :errorMessage="message" @close="closeError" />
                        <div class="my-5 text-center">
                            <p>Vous êtes déja un explorateur?<br>
                                <router-link :to="{ name: 'login' }">Se connecter</router-link>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </InitialLayout>
</template>

<script setup lang="ts">
import InitialLayout from '../layouts/InitialLayout.vue';
import { ref } from 'vue';
import { ExplorerRepository } from '@/repositories/ExplorerRepository';
import router from "@/router";
import ErrorModal from "@/components/ErrorModal.vue";

const userRepository = new ExplorerRepository();
const email = ref<string>("");
const username = ref<string>("");
const name = ref<string>("");
const surname = ref<string>("");
const password = ref<string>("");
const repeatPassword = ref<string>("");

const showError = ref<boolean>(false);
var message = "";
var navigationAllowed = false;

async function createAccount() {
    try {
        if (password.value === repeatPassword.value) {
            const response = await userRepository.CreateAccount(email.value, username.value, password.value, name.value, surname.value);
            if (response != null) {

                sessionStorage.setItem('token', response.tokens.accessToken);
                sessionStorage.setItem('refreshToken', response.tokens.refreshToken);
                sessionStorage.setItem('userHref', response.explorer.href);

                navigationAllowed = true;
            }
        } else {
            message = "Les mots de passe entrés ne sont pas identiques.";
            showError.value = true;
        }
    } catch (err) {
        switch (err.response.status) {
            case 409: {
                message = "Cette adresse courrielle est déja utilisé dans un compte. Veuillez vous connecter ou utiliser une autre adresse courrielle.";
                break;
            }
            case 500: {
                message = "Erreur interne du serveur, veuillez réessayer plus tard";
                break;
            }
            default: {
                message = "Erreur inconnue, veuillez réessayer plus tard";
                break;
            }
        }

        showError.value = true;
    }

    //Navigation
    if (navigationAllowed) {
        router.push({ name: 'allies' });
    }
}
function closeError() {
    showError.value = false;
    message = "";
}


</script>

<style scoped>
button {
    width: 200px;
    height: auto;
    margin: auto;
}
</style>