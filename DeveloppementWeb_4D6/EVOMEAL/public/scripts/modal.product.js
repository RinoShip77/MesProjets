$(document).ready(() => {
    //Will dynamically add the modal with product information
    $(".product-modal").click(async (event) => {
        event.preventDefault();

        const href = event.currentTarget.href;
        const response = await axios.get(href);
        if (response.status === 200) {
            $("#product-modal-content").html(response.data);
            const productViewModal = new bootstrap.Modal(document.getElementById('product-modal'), {});
            productViewModal.show();
        }
    });
})