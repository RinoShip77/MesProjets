<template>
  <div class="d-flex justify-content-around">
    <div>
      <canvas id="products-chart"></canvas>
    </div>
    <div>
      <canvas id="sales-chart"></canvas>
    </div>
  </div>
</template>

<script>
import Chart from 'chart.js/auto'

export default {
  mounted() {
    new Chart(document.getElementById('products-chart'), {
      type: 'doughnut',
      data: {
        datasets: [{
          data: [12, 19, 3, 5, 2, 3, 4, 11]
        }],
        labels: [
          "Case",
          "Cooler",
          "Motherboard",
          "Power supply",
          "CPU",
          "RAM",
          "Storage",
          "GPU"
        ]
      },
      options: {
        maintainAspectRatio: false
      }
    });

    new Chart(document.getElementById('sales-chart'), {
      type: 'line',
      data: {
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        datasets: [{
          label: '# of Votes',
          data: [12, 19, 3, 5, 2, 3],
          borderWidth: 1
        }]
      },
      options: {
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    });
  }
}
</script>
