<script setup>
import Dashboard from "./Dashboard.vue";
import Products from "./Products.vue";
import Customers from "./Customers.vue";
import { getUser } from "../../assets/js/helpers/functions";
</script>

<template>
  <div class="d-flex">
    <div class="col-3 d-flex flex-column flex-shrink-0 p-3 bg-body-secondary rounded-4 rounded-start-0 rounded-top-0">
      <a class="navbar-brand fs-1" href="">
        <i class="bi bi-tools"></i>
        MyBuilder
      </a>
      <hr>
      <ul class="nav nav-pills flex-column mb-auto" id="v-pills-tab" role="tablist" aria-orientation="vertical">
        <li class="nav-item">
          <button class="nav-link link-body-emphasis w-100 text-start active" id="v-pills-home-tab"
            data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home"
            aria-selected="true">
            <i class="bi bi-house-door-fill me-2"></i>
            Home
          </button>
        </li>
        <li class="nav-item">
          <button class="nav-link link-body-emphasis w-100 text-start" id="v-pills-dashboard-tab" data-bs-toggle="pill"
            data-bs-target="#v-pills-dashboard" type="button" role="tab" aria-controls="v-pills-dashboard"
            aria-selected="false" @click="change_tab($event.target.id)">
            <i class="bi bi-speedometer me-2"></i>
            Dashboard
          </button>
        </li>
        <li class="nav-item">
          <button class="nav-link link-body-emphasis w-100 text-start" id="v-pills-customers-tab" data-bs-toggle="pill"
            data-bs-target="#v-pills-customers" type="button" role="tab" aria-controls="v-pills-customers"
            aria-selected="false" @click="change_tab($event.target.id)">
            <i class="bi bi-people-fill me-2"></i>
            Customers
          </button>
        </li>
        <li class="nav-item">
          <button class="nav-link link-body-emphasis w-100 text-start" id="v-pills-products-tab" data-bs-toggle="pill"
            data-bs-target="#v-pills-products" type="button" role="tab" aria-controls="v-pills-products"
            aria-selected="false" @click="change_tab($event.target.id)">
            <i class="bi bi-grid-1x2-fill me-2"></i>
            Products
          </button>
        </li>
      </ul>
      <hr class="mt-5">
      <div class="d-flex dropdown mx-auto" type="button">
        <a class="d-flex align-items-center link-body-emphasis text-decoration-none position-relative dropdown-toggle"
          data-bs-toggle="dropdown" aria-expanded="false">
          <i class="bi bi-person-circle fs-4 me-2"></i>
          <strong>{{ getUser().firstName }}</strong>
          <span id="userStatus"
            class="position-absolute top-0 translate-middle ms-4 mt-1 p-2 bg-success border border-light rounded-circle">
            <span class="visually-hidden">Connected</span>
          </span>
        </a>
        <button class="nav-link text-reset ms-5" type="button" @click="switch_theme">
          <i id="themeSwitcher" class="bi bi-moon-stars-fill"></i>
        </button>
        <ul class="dropdown-menu text-small shadow">
          <li>
            <a class="dropdown-item" href="#">Settings</a>
          </li>
          <li>
            <a class="dropdown-item" href="#">Profile</a>
          </li>
          <li>
            <hr class="dropdown-divider">
          </li>
          <li>
            <button id="logoutLink" class="btn btn-link dropdown-item" @click="user_disconnect">
              Logout
            </button>
          </li>
        </ul>
      </div>
    </div>
    <div class="col tab-content p-4" id="v-pills-tabContent">
      <div class="tab-pane fade show d-flex flex-column gap-4" id="v-pills-home" role="tabpanel"
        aria-labelledby="v-pills-home-tab" tabindex="0">
        <div class="card p-3 shadow-lg">
          <Dashboard />
        </div>
        <div class="card p-3 shadow-lg">
          <Customers />
        </div>
        <div class="card p-3 shadow-lg overflow-y-scroll" style="height: 30vh;">
          <Products />
        </div>
      </div>
      <div class="tab-pane fade" id="v-pills-dashboard" role="tabpanel" aria-labelledby="v-pills-dashboard-tab"
        tabindex="0">
        <Dashboard />
      </div>
      <div class="tab-pane fade" id="v-pills-customers" role="tabpanel" aria-labelledby="v-pills-customers-tab"
        tabindex="0">
        <Customers />
      </div>
      <div class="tab-pane mb-auto fade" id="v-pills-products" role="tabpanel" aria-labelledby="v-pills-products-tab"
        tabindex="0">
        <Products />
      </div>
    </div>
  </div>
</template>

<script>
import { switchTheme } from "../../assets/js/helpers/functions";
import { disconnect } from "../../assets/js/components/user/user";

export default {
  methods: {
    change_tab(id) {
      document.getElementById(id.slice(0, id.lastIndexOf("-"))).style.marginTop = `-${document.getElementById("v-pills-home").clientHeight}px`;
    },

    switch_theme() {
      switchTheme();
    },

    user_disconnect() {
      disconnect();
    }
  }

};
</script>