<template>
    <v-sheet class="mx-auto mt-1 container" elevation="4" max-width="85%">
        <Message v-for="(message, index) in messages" :key="index" :msg="message" />
        <v-progress-circular
            v-if="isLoading"
            indeterminate
            color="primary"
            class="ma-4"
        ></v-progress-circular>
    </v-sheet>
    <v-sheet class="mx-auto mt-1 container pa-5" elevation="4" max-width="85%" height="auto">
        <div class="d-flex">
            <v-textarea
                label="prompt"
                variant="underlined"
                class="me-5"
                v-model="message"
                @keyup.enter.prevent="userInput"
                :disabled="isLoading"
            ></v-textarea>
            <v-btn 
                @click="userInput"
                icon="mdi-send"
                class="align-self-center"
                :disabled="isLoading"
            ></v-btn>
        </div>
    </v-sheet>
</template>

<script>
import Message from './Message.vue'
import { reactive, ref } from 'vue'

export default {
    components: {
        Message
    },
    setup() {
        const message = ref(null)
        const messages = reactive([])
        const isLoading = ref(false)

        const userInput = () => {
            if (!message.value || message.value.trim() === '') return;

            messages.push({
                role: 'user',
                content: message.value
            })
            const sentMessage = message.value
            message.value = null
            chat(sentMessage)
        }

        const chat = async (lastMessage) => {
            isLoading.value = true
            //const lastMessage = msgs[msgs.length - 1].content
            try {
                const apiUrl = `${import.meta.env.VITE_API_URL}/api/model`;
                const response = await fetch(apiUrl, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify({ question: lastMessage }),
                })
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const data = await response.json()
                messages.push({
                    role: 'assistant',
                    content: data.response // Asumiendo que la respuesta viene en el campo 'answer'
                })
            } catch (error) {
                console.error("Error al obtener la respuesta:", error)
            } finally {
                isLoading.value = false
            }
        }

        return { userInput, message, messages, isLoading }
    },
}
</script>

<style scoped>
.container {
    max-height: 75hv;
    overflow-y: auto;
    flex-direction: column;
}
</style>
