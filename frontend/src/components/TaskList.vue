<template>
  <div>
    <h1>Tasks</h1>
    <form @submit.prevent="createTask">
      <div>
        <label for="title">Title:</label>
        <input type="text" v-model="newTask.title" id="title" required />
      </div>
      <div>
        <label for="description">Description:</label>
        <input type="text" v-model="newTask.description" id="description" required />
      </div>
      <div>
        <label for="due_date">Due Date:</label>
        <input type="date" v-model="newTask.due_date" id="due_date" required />
      </div>
      <button type="submit">Create Task</button>
    </form>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Description</th>
          <th>Due Date</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="task in tasks" :key="task.id">
          <td>{{ task.id }}</td>
          <td>{{ task.title }}</td>
          <td>{{ task.description }}</td>
          <td>{{ formatDate(task.due_date) }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import apiClient from '../services/api';

export default {
  data() {
    return {
      tasks: [],
      newTask: {
        title: '',
        description: '',
        due_date: ''
      }
    };
  },
  mounted() {
    this.fetchTasks();
  },
  methods: {
    async fetchTasks() {
      try {
        const response = await apiClient.get('/tasks');
        this.tasks = response.data;
      } catch (error) {
        console.error('Error fetching tasks:', error);
      }
    },
    async createTask() {
      try {
        const response = await apiClient.post('/tasks', { task: this.newTask });
        this.tasks.push(response.data);
        this.newTask.title = '';
        this.newTask.description = '';
        this.newTask.due_date = '';
      } catch (error) {
        console.error('Error creating task:', error);
      }
    },
    formatDate(date) {
      const options = { year: 'numeric', month: 'long', day: 'numeric' };
      return new Date(date).toLocaleDateString(undefined, options);
    },
  },
};
</script>

<style>
table {
  width: 100%;
  border-collapse: collapse;
  margin: 20px 0;
}
th, td {
  border: 1px solid #ddd;
  padding: 8px;
}
th {
  background-color: #f2f2f2;
  text-align: left;
}
form {
  margin-bottom: 20px;
}
form div {
  margin-bottom: 10px;
}
label {
  display: block;
  margin-bottom: 5px;
}
input[type="text"],
input[type="date"] {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
}
button {
  padding: 10px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  cursor: pointer;
}
button:hover {
  background-color: #0056b3;
}
</style>
