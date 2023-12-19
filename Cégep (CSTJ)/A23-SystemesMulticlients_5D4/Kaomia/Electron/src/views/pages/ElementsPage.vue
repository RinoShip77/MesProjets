<template>
  <DefaultLayout>
    <h1 class="display-3 mb-5 pageTitle">
      <span class="text-decoration-underline">Mes Elements</span>
      <span v-if="explorer"> - ({{ explorer?.inventory.elements.length }})</span>
    </h1>
    <div class="loading" v-if="isLoading">
      <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
        style="margin: auto; background: rgba(241, 242, 243, 0); display: block;" width="200px" height="200px"
        viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
        <defs>
          <path id="path" d="M50 15A8 35 0 0 1 50 85A8 35 0 0 1 50 15" fill="none"></path>
          <path id="patha" d="M0 0A8 35 0 0 1 0 70A8 35 0 0 1 0 0" fill="none"></path>
        </defs>
        <g transform="rotate(0 50 50)">
          <use xlink:href="#path" stroke="#b7b7b7" stroke-width="2"></use>
        </g>
        <g transform="rotate(60 50 50)">
          <use xlink:href="#path" stroke="#b7b7b7" stroke-width="2"></use>
        </g>
        <g transform="rotate(120 50 50)">
          <use xlink:href="#path" stroke="#b7b7b7" stroke-width="2"></use>
        </g>
        <g transform="rotate(0 50 50)">
          <circle cx="50" cy="15" r="6" fill="#000000">
            <animateMotion dur="1s" repeatCount="indefinite" begin="0s">
              <mpath xlink:href="#patha"></mpath>
            </animateMotion>
          </circle>
        </g>
        <g transform="rotate(60 50 50)">
          <circle cx="50" cy="15" r="6" fill="#ff0000">
            <animateMotion dur="1s" repeatCount="indefinite" begin="-0.16666666666666666s">
              <mpath xlink:href="#patha"></mpath>
            </animateMotion>
          </circle>
        </g>
        <g transform="rotate(120 50 50)">
          <circle cx="50" cy="15" r="6" fill="#ffe100">
            <animateMotion dur="1s" repeatCount="indefinite" begin="-0.3333333333333333s">
              <mpath xlink:href="#patha"></mpath>
            </animateMotion>
          </circle>
        </g>
      </svg>
    </div>
    <div class="col-12 mt-5" v-else>
      <div v-if="canRetry">
        <div class="alert alert-danger fs-1 fw-bold w-50 mx-auto" role="alert">
          Impossible de récupérer les données
        </div>
        <button class="btn bg-transparent rounded-circle p-4" @click="retrieveElements()">
          <i class="fas fa-arrows-rotate" style="font-size: 6em"></i>
        </button>
      </div>
      <div class="row row-cols-4 content" v-else-if="explorer?.inventory.elements.length !== 0">
        <div class="col my-2" v-for="element of explorer?.inventory.elements">
          <div class="card border-2 border-body-secondary shadow-lg">
            <div class="card-header bg-body-tertiary">
              <h1 class="text-capitalize display-5 fw-bold">{{ element.element }}</h1>
            </div>
            <div class="card-body bg-info bg-opacity-75">
              <p class="fw-bold fs-4 mt-1">
                {{ element.quantity }}
                <i class="fas fa-boxes-stacked"></i>
              </p>
              <img :src="`elements/element_${element.element.toLowerCase()}.png`"
                class="img-fluid bg-body-tertiary rounded-circle shadow-lg w-75" :alt="`${element.element}`"
                :title="`Element ${element.element}`">
            </div>
          </div>
        </div>
      </div>
      <div v-else>
        <p class="fst-italic fw-bold fs-3">Aucun Element.</p>
      </div>
    </div>
  </DefaultLayout>
</template>

<script setup lang="ts">
import DefaultLayout from '@/views/layouts/DefaultLayout.vue';
import { onMounted, ref } from 'vue';
import { ExplorerRepository } from '@/repositories/ExplorerRepository';
import { Explorer } from '@/models/Explorer';

const explorerRepository = new ExplorerRepository();
const explorer = ref<Explorer>();
const isLoading = ref(true);
const canRetry = ref(false);

onMounted(async () => {
  setTimeout(() => {
    retrieveElements();
    isLoading.value = false;
  }, import.meta.env.VITE_LOADING_TIME);

  setInterval(retrieveElements, import.meta.env.VITE_REFRESH_RATE);
})

async function retrieveElements() {
  try {
    canRetry.value = false;
    explorer.value = await explorerRepository.retrieveOne(sessionStorage.getItem('userHref'), sessionStorage.getItem('token'));
  } catch (error) {
    canRetry.value = true;
  }
}
</script>

<style scoped></style>