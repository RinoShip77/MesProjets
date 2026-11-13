<template>
  <header>
    <nav class="navbar navbar-expand-xl bg-danger bg-opacity-75">
      <div class="container-fluid mx-1">
        <router-link class="navbar-brand d-flex align-items-center" :to="{ name: 'allies' }">
          <img :src="`logo.ico`" alt="Kaomia" title="Kaomia" class="img-fluid" width="125">
          <h1 class="ms-2 navTitle">Kaomia</h1>
        </router-link>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
          aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
          <div class="d-flex justify-content-around ms-auto">
            <div class="d-flex align-items-center">
              <button
                class="btn btn-danger d-flex align-items-center rounded-3 mt-1 px-4 fs-5 text-uppercase text-nowrap fw-bold"
                @click="disconnect()">
                <i class="fas fa-right-from-bracket fs-4 me-3"></i>
                Se déconnecter
              </button>
              <div class="nav-link mx-2">
                <img
                  :src="`https://ui-avatars.com/api/?name=${explorer?.name}+${explorer?.surname}&rounded=true&size=96`">
                <div style="margin-top: -1.25em; margin-left: 4.5em">
                  <span class="badge bg-success rounded-circle p-2">
                    <span class="visually-hidden">Connecté</span>
                  </span>
                </div>
              </div>
            </div>
            <div
              class="d-flex justify-content-between align-items-center bg-body w-100 rounded-4 ms-2 px-5 py-2 shadow-lg stats">
              <div class="d-flex flex-column text-center mt-2 me-3">
                <i class="fas fa-sack-dollar display-3"></i>
                <div class="d-flex align-items-center">
                  <span>{{ explorer?.inventory.inox }}</span>
                  <img :src="`ui/inox.png`" alt="Inox icon" class="img-fluid" width="60">
                </div>
              </div>
              <div class="d-flex flex-column text-center ms-3">
                <i class="fas fa-map-location-dot display-3"></i>
                <div class="d-flex justify-content-around mt-2">
                  <span class="fs-2 text-nowrap text-capitalize">{{ explorer?.location }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </nav>
  </header>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { ExplorerRepository } from '@/repositories/ExplorerRepository';
import { Explorer } from '@/models/Explorer';
import router from "@/router";

const explorerRepository = new ExplorerRepository();
const explorer = ref<Explorer>();

onMounted(async () => {
  retrieveExplorer();
  setInterval(retrieveExplorer, import.meta.env.VITE_REFRESH_RATE);
})

async function retrieveExplorer() {
  try {
    explorer.value = await explorerRepository.retrieveOne(sessionStorage.getItem('userHref'), sessionStorage.getItem('token'));
  } catch (error) {
    throw error;
  }
}

async function disconnect() {
  try {
    const response = await explorerRepository.logout(sessionStorage.getItem('token'));

    if (response != null) {
      sessionStorage.clear();
      router.push({ name: 'login' })
    }
  } catch (err) {
    alert('Erreur de connexion :\n' + err);
  }
}
</script>

<style scoped></style>