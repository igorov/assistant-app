<template>
    <v-sheet class="mx-auto mt-1 container" elevation="4" max-width="85%">
        <v-btn color="primary" @click="isPolling ? stopPolling() : startPolling()" style="width: 100%;">
            {{ isPolling ? 'Detener actualización' : 'Iniciar actualización' }}
        </v-btn>
    </v-sheet>
    <v-sheet class="mx-auto mt-1 container" elevation="4" max-width="85%">
        <ProductBarChart :products="products" style="height: 300px;" />
    </v-sheet>
    <v-sheet class="mx-auto mt-1 container pa-5" elevation="4" max-width="85%" height="auto">
        <v-table>
            <thead>
                <tr>
                    <th class="text-left">
                        Pregunta
                    </th>
                    <th class="text-left">
                        Respuesta
                    </th>
                    <th class="text-left">
                        Producto
                    </th>
                    <th class="text-left">
                        Fecha
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="item in questions" :key="item.name">
                    <td>{{ item.query }}</td>
                    <td>{{ item.response }}</td>
                    <td>{{ item.product }}</td>
                    <td>{{ item.date }}</td>
                </tr>
            </tbody>
        </v-table>
    </v-sheet>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import axios from 'axios'
import ProductBarChart from './ProductBarChart.vue'

const questions = ref([])
const products = ref({})
const isPolling = ref(false)
let intervalId = null

const startPolling = () => {
    console.log(`Starting polling ${isPolling.value}`);
    fetchQuestions()
    intervalId = setInterval(fetchQuestions, 1000)
    isPolling.value = true
}

const stopPolling = () => {
    console.log(`Stopping polling ${isPolling.value}`);
    if (intervalId) {
        clearInterval(intervalId)
        intervalId = null
        isPolling.value = false
    }
}

const fetchQuestions = async () => {
    console.log("Fetching questions");
    try {
        const response = await axios.get(`${import.meta.env.VITE_API_URL}/api/questions`)
        questions.value = response.data.questions
        products.value = response.data.products
    } catch (error) {
        console.error('Error fetching questions:', error)
    }
}

onMounted(fetchQuestions)
onUnmounted(stopPolling)
</script>