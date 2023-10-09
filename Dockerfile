# Stage 1: Build the React app
FROM node:18 as build

WORKDIR /app

COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

COPY . ./

# Build the React app
RUN npm run build

# Stage 2: Serve the React app using Nginx
FROM nginx:alpine

# Copy the built app from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 3000

# Start Nginx to serve the app
CMD ["nginx", "-g", "daemon off;"]