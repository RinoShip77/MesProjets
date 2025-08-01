<template>
    <table class=" table table-hover align-middle">
      <thead>
        <tr>
          <th scope="col">Visual</th>
          <th scope="col-3">Name</th>
          <th scope="col">Quantity</th>
          <th scope="col-2">Price</th>
          <th scope="col">Operation</th>
        </tr>
      </thead>
      <tbody id="adminProductsContainer">
      </tbody>
    </table>
</template>

<script>
import { getAdminProducts } from '@/assets/js';

export default {
  mounted() {
    getAdminProducts();
  }
}
</script>