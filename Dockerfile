# FROM node:18-alpine
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . ./
# EXPOSE 3000
# CMD ["npm", "run", "start"]

# Stage 1: Build the application
FROM node:18-alpine AS build

# Set the Working Directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install Dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Stage 2: Create a lightweight production image
FROM node:18-alpine AS production

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app .

# Install only production dependencies
RUN npm install --only=production

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]