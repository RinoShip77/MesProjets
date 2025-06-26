<template>
  <div class="row d-flex justify-content-center p-5">
    <div class="col-auto">
      <h1>Categories</h1>
      <div id="categoriesContainer" class="ms-3 fs-5"></div>
    </div>
    <div class="col-9 ms-xl-auto">
      <div id="productsContainer"
        class="row row-cols-1 row-cols-sm-2 row-cols-xl-4 row-cols-xxl-6 g-4 overflow-y-scroll" style="height: 75vh;">
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted } from 'vue';
import { main } from "@/assets/js/index";

onMounted(() => {
  main();
});
// TODO: Create the admin dashboard
</script>