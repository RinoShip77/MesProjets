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
                <div class="d-flex justify-content-center">
                    <div class="col-4 mx-2 my-2">
                        <form class="form" @submit="login(false)">
                            <label for="email" type="email" class="form-label">Adresse Courrielle</label>
                            <input v-model="email" class="form-control" id="email" required>
                            <label for="password" class="form-label">Mot de passe</label>
                            <input v-model="password" type="password" class="form-control" id="password" required>
                            <input type="submit" class="form-control btn btn-primary my-4" value="Se connecter">
                        </form>

                        <ErrorModal v-if="showError" :errorMessage="message" @close="closeError" />

                        <div class="text-center">
                            <button class="bg-transparent border-0 text-primary text-decoration-underline"
                                @click="login(true)">Tricher</button>
                        </div>

                        <div class="my-5 text-center">
                            <p>Vous êtes un citoyen et voulez être un explorateur?<br>
                                <router-link :to="{ name: 'accountCreation' }">Créer un compte</router-link>
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
const password = ref<string>("");

const showError = ref<boolean>(false);
var message = "";
var navigationAllowed = false;

async function login(cheat: boolean) {

    try {
        if (cheat) {
            email.value = "bob.gratton@email.ca";
            password.value = "Canayen101";
        }

        const response = await userRepository.login(email.value, password.value);

        if (response != null) {

            sessionStorage.setItem('token', response.tokens.accessToken);
            sessionStorage.setItem('refreshToken', response.tokens.refreshToken);
            sessionStorage.setItem('userHref', response.explorer.href);

            message = "";
            showError.value = false;

            navigationAllowed = true;
        }
        //Navigation
        if (navigationAllowed) {
            router.push({ name: 'allies' });
        }
    } catch (err) {
        switch (err.response.status) {
            case 401: {
                message = "Identifiants de connexion invalides, veuillez réessayer.";
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


}

function closeError() {
    showError.value = false;
    message = "";
}
</script>

<style scoped></style>