<template>
  <DefaultLayout>
    <h1 class="display-3 mb-5 pageTitle">
      <span class="text-decoration-underline">Mes Allies</span>
      <span v-if="allies"> - ({{ allies?.length }})</span>
    </h1>
    <div class="loading" v-if="isLoading">
      <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
        style="margin: auto; background: rgba(241, 242, 243, 0); display: block;" width="200px" height="200px"
        viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
        <circle cx="6.451612903225806" cy="50" r="3" fill="#0074e4">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-0.5s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="0s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#0074e4;#ffffff;#0074e4" dur="2s"
            repeatCount="indefinite" begin="-0.5s"></animate>
        </circle>
        <circle cx="6.451612903225806" cy="50" r="3" fill="#74c005">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-1.5s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-1s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#74c005;#0074e4;#74c005" dur="2s"
            repeatCount="indefinite" begin="-0.5s"></animate>
        </circle>
        <circle cx="16.129032258064512" cy="50" r="3" fill="#0074e4">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-0.7s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-0.2s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#0074e4;#ffffff;#0074e4" dur="2s"
            repeatCount="indefinite" begin="-0.7s"></animate>
        </circle>
        <circle cx="16.129032258064512" cy="50" r="3" fill="#74c005">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-1.7s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-1.2s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#74c005;#0074e4;#74c005" dur="2s"
            repeatCount="indefinite" begin="-0.7s"></animate>
        </circle>
        <circle cx="25.806451612903224" cy="50" r="3" fill="#0074e4">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-0.9s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-0.4s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#0074e4;#ffffff;#0074e4" dur="2s"
            repeatCount="indefinite" begin="-0.9s"></animate>
        </circle>
        <circle cx="25.806451612903224" cy="50" r="3" fill="#74c005">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-1.9s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-1.4s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#74c005;#0074e4;#74c005" dur="2s"
            repeatCount="indefinite" begin="-0.9s"></animate>
        </circle>
        <circle cx="35.48387096774193" cy="50" r="3" fill="#0074e4">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-1.1s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-0.6s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#0074e4;#ffffff;#0074e4" dur="2s"
            repeatCount="indefinite" begin="-1.1s"></animate>
        </circle>
        <circle cx="35.48387096774193" cy="50" r="3" fill="#74c005">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-2.1s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-1.6s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#74c005;#0074e4;#74c005" dur="2s"
            repeatCount="indefinite" begin="-1.1s"></animate>
        </circle>
        <circle cx="45.16129032258064" cy="50" r="3" fill="#0074e4">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-1.3s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-0.8s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#0074e4;#ffffff;#0074e4" dur="2s"
            repeatCount="indefinite" begin="-1.3s"></animate>
        </circle>
        <circle cx="45.16129032258064" cy="50" r="3" fill="#74c005">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-2.3s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-1.8s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#74c005;#0074e4;#74c005" dur="2s"
            repeatCount="indefinite" begin="-1.3s"></animate>
        </circle>
        <circle cx="54.838709677419345" cy="50" r="3" fill="#0074e4">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-1.5s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-1s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#0074e4;#ffffff;#0074e4" dur="2s"
            repeatCount="indefinite" begin="-1.5s"></animate>
        </circle>
        <circle cx="54.838709677419345" cy="50" r="3" fill="#74c005">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-2.5s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-2s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#74c005;#0074e4;#74c005" dur="2s"
            repeatCount="indefinite" begin="-1.5s"></animate>
        </circle>
        <circle cx="64.51612903225805" cy="50" r="3" fill="#0074e4">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-1.7s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-1.2s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#0074e4;#ffffff;#0074e4" dur="2s"
            repeatCount="indefinite" begin="-1.7s"></animate>
        </circle>
        <circle cx="64.51612903225805" cy="50" r="3" fill="#74c005">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-2.7s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-2.2s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#74c005;#0074e4;#74c005" dur="2s"
            repeatCount="indefinite" begin="-1.7s"></animate>
        </circle>
        <circle cx="74.19354838709677" cy="50" r="3" fill="#0074e4">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-1.9s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-1.4s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#0074e4;#ffffff;#0074e4" dur="2s"
            repeatCount="indefinite" begin="-1.9s"></animate>
        </circle>
        <circle cx="74.19354838709677" cy="50" r="3" fill="#74c005">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-2.9s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-2.4s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#74c005;#0074e4;#74c005" dur="2s"
            repeatCount="indefinite" begin="-1.9s"></animate>
        </circle>
        <circle cx="83.87096774193547" cy="50" r="3" fill="#0074e4">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-2.1s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-1.6s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#0074e4;#ffffff;#0074e4" dur="2s"
            repeatCount="indefinite" begin="-2.1s"></animate>
        </circle>
        <circle cx="83.87096774193547" cy="50" r="3" fill="#74c005">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-3.1s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-2.6s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#74c005;#0074e4;#74c005" dur="2s"
            repeatCount="indefinite" begin="-2.1s"></animate>
        </circle>
        <circle cx="93.54838709677418" cy="50" r="3" fill="#0074e4">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-2.3s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-1.8s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#0074e4;#ffffff;#0074e4" dur="2s"
            repeatCount="indefinite" begin="-2.3s"></animate>
        </circle>
        <circle cx="93.54838709677418" cy="50" r="3" fill="#74c005">
          <animate attributeName="r" times="0;0.5;1" values="2.4000000000000004;3.5999999999999996;2.4000000000000004"
            dur="2s" repeatCount="indefinite" begin="-3.3s"></animate>
          <animate attributeName="cy" keyTimes="0;0.5;1" values="32;68;32" dur="2s" repeatCount="indefinite" begin="-2.8s"
            keySplines="0.5 0 0.5 1;0.5 0 0.5 1" calcMode="spline"></animate>
          <animate attributeName="fill" keyTimes="0;0.5;1" values="#74c005;#0074e4;#74c005" dur="2s"
            repeatCount="indefinite" begin="-2.3s"></animate>
        </circle>
      </svg>
    </div>
    <div class="col-12 mt-5" v-else>
      <div v-if="canRetry">
        <div class="alert alert-danger fs-1 fw-bold w-50 mx-auto" role="alert">
          Impossible de récupérer les données
        </div>
        <button class="btn bg-transparent rounded-circle p-4" @click="retrieveAllies()">
          <i class="fas fa-arrows-rotate" style="font-size: 4em"></i>
        </button>
      </div>
      <div class="row row-cols-4 content" v-else-if="allies?.length !== 0">
        <div class="col my-2" v-for="ally of allies">
          <div class="card border-2 border-body-secondary shadow-lg" type="button" data-bs-toggle="modal"
            data-bs-target="#allyModal" @click="openModal(ally)">
            <div class="card-header bg-body-tertiary">
              <h1 class="text-capitalize display-5 fw-bold">{{ ally.name }}</h1>
            </div>
            <div class="card-body bg-info bg-opacity-75">
              <img :src="ally.asset" class="img-fluid bg-body-tertiary rounded-circle shadow-lg w-75">
              <div class="d-flex justify-content-between mt-3" title="Attributs">
                <img :src="`books/${ally.books[0]}.png`" class="img-fluid w-25 mt-4" :alt="`Livre ${ally?.books[0]}`"
                  title="Premier livre">
                <img :src="`affinities/${ally.affinity}.png`" class="img-fluid w-25 h-25" :alt="ally?.affinity"
                  :title="`Affinité '${ally?.affinity}'`">
                <img :src="`books/${ally.books[1]}.png`" class="img-fluid w-25 mt-4" :alt="`Livre ${ally?.books[1]}`"
                  title="Deuxième livre">
              </div>
              <div class="d-flex justify-content-around border-top mt-3 pt-3" title="Statistiques">
                <div class="d-flex flex-column" title="Power">
                  <img :src="`ui/power.png`" class="img-fluid" width="25">
                  <p>{{ ally.stats.power }}</p>
                </div>
                <div class="d-flex flex-column" title="Speed">
                  <img :src="`ui/speed.png`" class="img-fluid" width="25">
                  <p>{{ ally.stats.speed }}</p>
                </div>
                <div class="d-flex flex-column" title="Shield">
                  <img :src="`ui/shield.png`" class="img-fluid" width="25">
                  <p>{{ ally.stats.shield }}</p>
                </div>
                <div class="d-flex flex-column" title="Life">
                  <img :src="`ui/life.png`" class="img-fluid" width="25">
                  <p>{{ ally.stats.life }}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div v-else>
        <p class="fst-italic fw-bold fs-3">Aucun Ally.</p>
      </div>
    </div>
  </DefaultLayout>

  <!-- Modal for the details of one Ally -->
  <div class="modal fade" id="allyModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-xl">
      <div class="modal-content d-flex rounded-5 p-3 bg-danger bg-opacity-75">
        <div class="card w-auto p-2 rounded-5 bg-info bg-opacity-75">
          <div class="d-flex justify-content-between">
            <img :src="ally?.asset" class="img-fluid rounded-5 m-1 w-50">
            <div class="d-flex flex-column m-1 bg-info-subtle rounded-5 content">
              <div class="d-flex flex-column justify-content-between mt-3">
                <div class="d-flex justify-content-around mb-3">
                  <div class="d-flex flex-column text-center">
                    <span class="text-capitalize display-5 fw-bold">{{ ally?.name }}</span>
                    <span class="opacity-75">Essence : {{ ally?.essence }}</span>
                  </div>
                  <div class="d-flex flex-column text-center">
                    <h3>Date de capture:</h3>
                    <span class="border border-2 border-black rounded-3 opacity-75 px-2 fs-5 text-nowrap">
                      {{ ally?.createdAt.toString().split('T')[0] }}
                    </span>
                  </div>
                </div>
                <div class="d-flex ms-5 mt-2 mb-4">
                  <div class="d-flex flex-column" title="Statistiques">
                    <div class="d-flex flex-column ms-2 fs-4">
                      <div class="d-flex align-items-center" title="Power">
                        <img :src="`ui/power.png`" class="img-fluid w-50">
                        <span class="ms-2">{{ ally?.stats.power }}</span>
                      </div>
                      <div class="d-flex align-items-center" title="Speed">
                        <img :src="`ui/speed.png`" class="img-fluid w-50">
                        <span class="ms-2">{{ ally?.stats.speed }}</span>
                      </div>
                      <div class="d-flex align-items-center" title="Shield">
                        <img :src="`ui/shield.png`" class="img-fluid w-50">
                        <span class="ms-2">{{ ally?.stats.shield }}</span>
                      </div>
                      <div class="d-flex align-items-center" title="Life">
                        <img :src="`ui/life.png`" class="img-fluid w-50">
                        <span class="ms-2">{{ ally?.stats.life }}</span>
                      </div>
                    </div>
                  </div>
                  <div class="d-flex flex-column my-auto text-center" title="Attributs">
                    <div class="d-flex mt-3 bg-danger bg-opacity-25 rounded-4 me-2 py-3">
                      <div class="d-flex flex-column mt-5">
                        <img :src="`books/${ally?.books[0]}.png`" class="img-fluid w-75 mx-auto" type="button"
                          :alt="`Livre ${ally?.books[0]}`" title="Premier livre">
                      </div>
                      <div class="d-flex flex-column mb-5">
                        <img :src="`affinities/${ally?.affinity}.png`" class="img-fluid w-100 mx-auto" type="button"
                          :alt="ally?.affinity" :title="`Affinité '${ally?.affinity}'`">
                      </div>
                      <div class="d-flex flex-column mt-5">
                        <img :src="`books/${ally?.books[1]}.png`" class="img-fluid w-75 mx-auto" type="button"
                          :alt="`Livre ${ally?.books[1]}`" title="Deuxième livre">
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="d-flex flex-column mt-2 rounded-5 text-center" type="button" title="Noyau">
                <div class="d-flex">
                  <div class="d-flex flex-column text-center" v-for="kernel of ally?.kernel">
                    <img :src="`elements/element_${kernel.toLowerCase()}.png`" class="img-fluid" :alt="kernel"
                      :title="`Element ${kernel}`">
                    <h4 class="text-capitalize">{{ kernel }}</h4>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import DefaultLayout from '@/views/layouts/DefaultLayout.vue';
import { onMounted, ref } from 'vue';
import { AllyRepository } from '@/repositories/AllyRepository';
import { Ally } from '@/models/Ally';

const allyRepository = new AllyRepository();
const allies = ref<Ally[]>();
const ally = ref<Ally>();
const isLoading = ref(true);
const canRetry = ref(false);

onMounted(async () => {
  setTimeout(() => {
    retrieveAllies();
    isLoading.value = false;
  }, import.meta.env.VITE_LOADING_TIME);

  setInterval(retrieveAllies, import.meta.env.VITE_REFRESH_RATE);
})

async function retrieveAllies() {
  try {
    canRetry.value = false;
    allies.value = await allyRepository.retrieveAll(sessionStorage.getItem('userHref'), sessionStorage.getItem('token'));
  } catch (error) {
    canRetry.value = true;
  }
}

async function openModal(recievedAlly: Ally) {
  ally.value = recievedAlly;
}
</script>

<style scoped></style>