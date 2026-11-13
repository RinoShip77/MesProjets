<template class="d-flex">
  <NavBar></NavBar>
  <NavTabs>
    <slot></slot>
  </NavTabs>
  <Footer></Footer>
</template>

<script setup lang="ts">
import NavBar from '@/components/NavBar.vue';
import NavTabs from '@/components/NavTabs.vue';
import Footer from '@/components/Footer.vue';
</script>

<style scoped></style>