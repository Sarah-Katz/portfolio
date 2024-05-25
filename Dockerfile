# Stage 1: Build the Vite project
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the built files using http-server
FROM node:18-alpine
RUN npm install -g http-server
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8079
CMD ["http-server", "/usr/share/nginx/html", "-p", "8079"]
