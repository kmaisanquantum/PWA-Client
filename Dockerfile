# Stage 1: Build the React PWA application
FROM node:22-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the compiled static assets using Nginx Alpine
FROM nginx:alpine
# Copy the compiled Vite distribution files over to Nginx's HTML serving root
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]