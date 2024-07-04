<template>
    <Bar :data="chartData" :options="chartOptions" />
</template>

<script setup>
import { ref, computed } from 'vue';
import { Bar } from 'vue-chartjs';
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js';

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale);

const props = defineProps({
    products: {
        type: Object,
        required: true
    }
});

const chartData = computed(() => ({
    labels: Object.keys(props.products),
    datasets: [
        {
            label: 'Cantidad de preguntas por producto',
            data: Object.values(props.products),
            backgroundColor: 'rgba(75, 192, 192, 0.6)',
        }
    ]
}));

const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
};
</script>