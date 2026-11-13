<template>
  <div class="d-flex">
    <aside class="bg-primary-subtle rounded-end-5 mt-3 me-5 ps-3 pt-5 shadow-lg d-flex flex-column" style="width: 30rem">
      <router-link class="text-primary-emphasis text-decoration-none fs-3 fw-bold p-4" :to="{ name: 'allies' }">
        Allies
      </router-link>
      <router-link class="text-primary-emphasis text-decoration-none fs-3 fw-bold p-4" :to="{ name: 'elements' }">
        Elements
      </router-link>
      <router-link class="text-primary-emphasis text-decoration-none fs-3 fw-bold p-4" :to="{ name: 'leaderboard' }">
        Leaderboard
      </router-link>
      <div class="mx-auto mt-auto mb-4 d-flex fs-3">
        <label>
          <i class="fas fa-sun me-2"></i>
        </label>
        <div class="form-check form-switch">
          <input class="form-check-input" type="checkbox" role="switch" v-model="colorSwitch" @click="switchTheme()">
        </div>
        <label>
          <i class="fas fa-moon"></i>
        </label>
      </div>
    </aside>
    <div
      class="border border-3 rounded-start-5 rounded-end-4 p-5 overflow-auto shadow-lg ms-3 mt-3 me-1 text-center bg-info-subtle bg-opacity-75"
      style="width: 120rem; height: 45rem">
      <slot class="m-5"></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';

let colorSwitch = ref(false);

onMounted(() => {
  if (localStorage.getItem('theme') !== null) {
    if (localStorage.getItem('theme') !== 'light') {
      colorSwitch.value = true;
    } else {
      colorSwitch.value = false;
    }
  }
})

function switchTheme() {
  if (!colorSwitch.value) {
    localStorage.setItem('theme', 'dark')
  } else {
    localStorage.setItem('theme', 'light')
  }

  window.location.reload();
}
</script>

<style scoped>
::-webkit-scrollbar-track {
  border-radius: 10px;
}
</style>