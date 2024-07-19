# Stage 1: Build the application
FROM node:16 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and yarn.lock
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code
COPY . .

# Build the application
RUN yarn build

# Stage 2: Serve the application
FROM node:16-alpine

# Install serve globally
RUN yarn global add serve

# Copy the built application from the previous stage
COPY --from=build /app/dist /app

# Expose the port the app runs on
EXPOSE 8080

# Start the server
CMD ["serve", "-s", "/app", "-l", "8080"]
