<script setup>
import Admin from './components/Admin/Admin.vue'
import Header from './components/Core/Header.vue'
import Main from './components/Main.vue'
import Footer from './components/Core/Footer.vue'
import { isAdmin } from './assets/js/helpers/functions'
</script>

<template>
  
  <!-- #region Home page -->
  
  <div v-if="isAdmin()">
    <Admin />
  </div>
  <div v-else>
    <Header />
    <Main />
  </div>

  <Footer />
  <!-- #endregion Home page -->

  <!--  #region Toasts -->
  <!-- Add to cart toast -->
  <div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="cartToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
      <div class="toast-header">
        <img id="cartToastImage" class="rounded me-2" width="35" height="35">
        <strong id="cartToastTitle" class="me-auto"></strong>
        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
      <div id="cartToastMessage" class="toast-body"></div>
    </div>
  </div>

  <!-- Login toast -->
  <div class="toast-container position-fixed top-0 start-50 translate-middle-x p-3">
    <div id="loginToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
      <div class="d-flex">
        <div id="loginToastMessage" class="toast-body text-white fs-5"></div>
        <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
    </div>
  </div>

  <!-- Warning toast -->
  <div class="toast-container position-fixed top-0 start-50 translate-middle-x p-3">
    <div id="warningToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
      <div class="d-flex bg-warning">
        <div id="warningToastMessage" class="toast-body"></div>
        <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
    </div>
  </div>
  <!-- #endregion Toasts -->
</template>
