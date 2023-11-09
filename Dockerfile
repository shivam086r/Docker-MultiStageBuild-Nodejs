# Stage 1: Build the Node.js application
FROM node:14 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2: Create a lightweight production image
FROM node:14-slim
WORKDIR /app
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/app.js ./
EXPOSE 3000
CMD ["npm", "start"]

