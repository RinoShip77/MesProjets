<template>
    <!-- Un layout à utiliser quand un utilisateur n'est pas connecté -->
    <slot>

    </slot>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';

onMounted(async () => {
    sessionStorage.clear();
})
</script>