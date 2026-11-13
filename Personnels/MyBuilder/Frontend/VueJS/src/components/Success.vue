<template>
  <div class="px-4 py-5 my-5 text-center">
    <h1 class="d-flex flex-column text-center fw-bold gap-3 my-5">
      <i class="bi bi-check2-circle text-success display-1"></i>
      <span>Thank you <span id="customerName">{{ customerName }}</span> for your order!</span>
    </h1>
    <div class="d-flex flex-column align-items-center bg-body-tertiary rounded-3 my-5 gap-3">
      <div class="d-flex justify-content-between fs-5 gap-5">
        <div class="d-flex justify-content-between gap-5">
          <p class="fw-bolder me-3">Order number</p>
          <p id="orderNumber" data-bs-toggle="tooltip" :data-bs-title="orderTooltip">{{ orderNumber }}</p>
        </div>
        <div class="d-flex justify-content-between gap-5">
          <p class="fw-bolder ms-5 me-3">Total</p>
          <p>$<span id="checkoutTotal">{{ checkoutTotal }}</span></p>
        </div>
      </div>
      <div class="d-flex justify-content-between fs-5 gap-5">
        <p class="fw-bolder">Order date</p>
        <p id="orderDate">{{ orderDate }}</p>
      </div>
    </div>
    <div class="bg-body-tertiary rounded text-center m-2 p-3">
      <div class="row">
        <div class="col-3 fs-4">
          <i class="fs-1 text-success fas fa-circle-check"></i><br>In progress
        </div>
        <div class="col-3 fs-4">
          <i class="fs-1 text-danger fas fa-circle-xmark"></i><br>Send
        </div>
        <div class="col-3 fs-4">
          <i class="fs-1 text-danger fas fa-circle-xmark"></i><br>In route
        </div>
        <div class="col-3 fs-4">
          <i class="fs-1 text-danger fas fa-circle-xmark"></i><br>Delivered
        </div>
      </div>
      <div class="progress">
        <div class="bg-success progress-bar progress-bar-striped progress-bar-animated" style="width: 25%"></div>
        <div class="bg-danger progress-bar progress-bar-striped progress-bar-animated" style="width: 25%"></div>
        <div class="bg-danger progress-bar progress-bar-striped progress-bar-animated" style="width: 25%"></div>
        <div class="bg-danger progress-bar progress-bar-striped progress-bar-animated" style="width: 25%"></div>
      </div>
    </div>
    <div class="mt-5">
      <p class="lead mb-3">
        We appreciate your business! If you have any questions, please email
        <a href="mailto:mybuilder@support.com">mybuilder@support.com</a>.
      </p>
      <a href="../../index.html" class="btn btn-success">
        Go back to home
        <i class="bi bi-box-arrow-in-left"></i>
      </a>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    const urlParam = new URLSearchParams(location.search);
    const date = new Date(urlParam.get("date") * 1000);
    
    return {
      customerName: urlParam.get("name"),
      orderNumber: `${urlParam.get("order").slice(0, 15)}...`,
      orderTooltip: urlParam.get("order"),
      checkoutTotal: parseFloat(urlParam.get("total")) / 100,
      orderDate: `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}, ${date.toLocaleTimeString()}`
    }
  },
  mounted() {
    new bootstrap.Tooltip(document.getElementById("orderNumber"), { container: document.body });
  }
}
</script>