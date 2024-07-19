<template>
  <div>
    <h1>Tasks</h1>
    <form @submit.prevent="isEditing ? updateTask() : createTask()">
      <div>
        <label for="title">Title:</label>
        <input type="text" v-model="taskForm.title" id="title" required />
      </div>
      <div>
        <label for="description">Description:</label>
        <input type="text" v-model="taskForm.description" id="description" required />
      </div>
      <div>
        <label for="due_date">Due Date:</label>
        <input type="date" v-model="taskForm.due_date" id="due_date" required />
      </div>
      <button type="submit">{{ isEditing ? 'Update Task' : 'Create Task' }}</button>
      <button type="button" v-if="isEditing" @click="cancelEdit()">Cancel</button>
    </form>

    <form @submit.prevent="updateDueDate">
      <div>
        <label for="new_due_date">New Due Date:</label>
        <input type="date" v-model="newDueDate" id="new_due_date" required />
      </div>
      <button type="submit">Update Due Date for All Tasks</button>
    </form>

    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Description</th>
          <th>Due Date</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="task in tasks" :key="task.id">
          <td>{{ task.id }}</td>
          <td>{{ task.title }}</td>
          <td>{{ task.description }}</td>
          <td>{{ formatDate(task.due_date) }}</td>
          <td>
            <button @click="editTask(task)">Edit</button>
            <button @click="deleteTask(task.id)">Delete</button>
          </td>
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
      taskForm: {
        id: null,
        title: '',
        description: '',
        due_date: ''
      },
      newDueDate: '',
      isEditing: false,
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
        const response = await apiClient.post('/tasks', { task: this.taskForm });
        this.tasks.push(response.data);
        this.resetForm();
      } catch (error) {
        console.error('Error creating task:', error);
      }
    },
    async updateTask() {
      try {
        const response = await apiClient.put(`/tasks/${this.taskForm.id}`, { task: this.taskForm });
        const index = this.tasks.findIndex(task => task.id === this.taskForm.id);
        if (index !== -1) {
          this.tasks.splice(index, 1, response.data);
        }
        this.resetForm();
        this.isEditing = false;
      } catch (error) {
        console.error('Error updating task:', error);
      }
    },
    async deleteTask(taskId) {
      try {
        await apiClient.delete(`/tasks/${taskId}`);
        this.tasks = this.tasks.filter(task => task.id !== taskId);
      } catch (error) {
        console.error('Error deleting task:', error);
      }
    },
    editTask(task) {
      this.taskForm = { ...task };
      this.isEditing = true;
    },
    cancelEdit() {
      this.resetForm();
      this.isEditing = false;
    },
    resetForm() {
      this.taskForm = {
        id: null,
        title: '',
        description: '',
        due_date: ''
      };
    },
    formatDate(date) {
      const options = { year: 'numeric', month: 'long', day: 'numeric' };
      return new Date(date).toLocaleDateString(undefined, options);
    },
    async updateDueDate() {
      try {
        const response = await apiClient.post(`/tasks/update_due_date`, {
          due_date: this.newDueDate,
        });
        console.log('Response:', response.data);
        // Update the local tasks list with the new due date
        this.tasks.forEach(task => {
          task.due_date = this.newDueDate;
        });
        this.newDueDate = '';
      } catch (error) {
        console.error('Error updating due date:', error);
      }
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
input[type="date"],
select {
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
  margin-right: 5px;
}
button:hover {
  background-color: #0056b3;
}
</style>
