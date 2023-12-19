<template>
  <footer class="d-flex flex-wrap justify-content-between align-items-center my-4 px-4 py-3 border-top">
    <div class="d-flex align-items-center">
      <router-link class="d-flex align-items-center text-decoration-none" :to="{ name: 'allies' }">
        <h4 class="text-body-tertiary footerTitle">© 2023 Consortium, Inc</h4>
      </router-link>
    </div>
    <p class="text-center text-body-secondary">
      Ce site à été produit dans un cadre pédagogique pour un <a
        href="https://www.cstj.qc.ca/programmes/techniques-de-linformatique/">cours</a>.<br>
      Il s'agit d'un univers fictif.
    </p>
    <ul class="nav justify-content-end list-unstyled d-flex fs-2 me-3">
      <li class="ms-3">
        <a class="text-body-secondary" href="https://github.com/">
          <i class="fa-brands fa-github"></i>
        </a>
      </li>
      <li class="ms-3">
        <a class="text-body-secondary" href="https://getbootstrap.com/">
          <i class="fa-brands fa-bootstrap"></i>
        </a>
      </li>
      <li class="ms-3">
        <a class="text-body-secondary" href="https://developer.mozilla.org/fr/docs/Glossary/HTML5">
          <i class="fa-brands fa-html5"></i>
        </a>
      </li>
      <li class="ms-3">
        <a class="text-body-secondary" href="https://vuejs.org/">
          <i class="fa-brands fa-vuejs"></i>
        </a>
      </li>
      <li class="ms-3">
        <a class="text-body-secondary" href="https://nodejs.org/en">
          <i class="fa-brands fa-node-js"></i>
        </a>
      </li>
    </ul>
  </footer>
</template>

<script setup lang="ts">
</script>

<style scoped></style>