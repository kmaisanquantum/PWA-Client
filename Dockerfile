# Stage 1: Build the React PWA application using modern Node 22
FROM node:22-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the compiled static assets using Nginx Alpine
FROM nginx:alpine
# Copy the compiled Vite distribution files over to the default Nginx html folder
COPY --from=build-stage /app/dist /usr/share/nginx/html
# Copy default SPA routing handling if necessary
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]