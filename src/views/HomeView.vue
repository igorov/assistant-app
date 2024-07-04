<script setup>
import { ref } from 'vue';
import Chat from '../components/Chat.vue';
import Stats from '../components/Stats.vue';

// Define una variable reactiva para controlar la pestaña activa
const tab = ref(1);
</script>

<template>
  <main>
    <v-tabs
      v-model="tab"
      align-tabs="center"
      color="primary"
    >
      <v-tab :value="1">Chat</v-tab>
      <v-tab :value="2">Estadística global de preguntas realizadas</v-tab>
    </v-tabs>

    <v-window v-model="tab">
      <v-window-item
        :key="1"
        :value="1"
      >
        <Chat />
      </v-window-item>
      <v-window-item
        :key="2"
        :value="2"
      >
        <Stats />
      </v-window-item>
    </v-window>
  </main>
</template>