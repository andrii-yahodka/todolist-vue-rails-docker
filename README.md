# Dockerized To-Do List Application

This project is a Dockerized To-Do List application that utilizes Vue.js for the frontend and Ruby on Rails for the backend API. The setup includes a PostgreSQL database and Redis for background job processing with Sidekiq.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Running the Application](#running-the-application)

## Overview

This application demonstrates a full-stack to-do list application with separate frontend and backend services managed using Docker Compose. The frontend is built with Vue.js, while the backend is built with Ruby on Rails. The application also uses PostgreSQL for data storage and Redis for background job processing with Sidekiq.

## Features

- **Vue.js Frontend**: A responsive and interactive user interface for managing tasks.
- **Rails API Backend**: A robust and scalable API for handling task operations.
- **PostgreSQL**: A powerful, open-source object-relational database system.
- **Redis**: An in-memory data structure store used as a database, cache, and message broker.
- **Sidekiq**: A background job processor to handle asynchronous tasks.

## Architecture

- **Frontend**: Vue.js application running on Node.js.
- **Backend**: Ruby on Rails API.
- **Database**: PostgreSQL.
- **Caching and Background Jobs**: Redis and Sidekiq.

## Prerequisites

- Docker
- Docker Compose

## Project Structure

```
  todolist-vue-rails-docker/
  ├── backend/          
  ├── frontend/         
  ├── .env              
  ├── docker-compose.yml
  └── README.md         
```

## Running the Application

```
  docker-compose up --build
```
