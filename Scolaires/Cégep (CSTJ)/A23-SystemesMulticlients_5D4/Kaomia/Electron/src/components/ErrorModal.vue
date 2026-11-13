<template>
    <div class="error-modal">
        <div class="modal-content bg-danger d-flex justify-content-center">
            <h3>{{ errorMessage }}</h3>
            <button @click="closeModal" class="btn btn-secondary">Fermer</button>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        errorMessage: String,
    },
    methods: {
        closeModal() {
            this.$emit('close');
        },
    },
};
</script>

<style scoped>
.error-modal {
    position: fixed;
    top: 0;
    left: 25%;
    width: 50%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.modal-content {
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

button {
    width: 25%;
    align-self: center;
}
</style>