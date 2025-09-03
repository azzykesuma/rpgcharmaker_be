# Stage 1: Build
FROM node:22-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json to leverage Docker layer caching
COPY package.json package-lock.json* ./

# Install dependencies, including dev dependencies for building
RUN npm install

# Copy the rest of the application source code
COPY . .
COPY .env ./

# Run the build process (assuming your project uses a build step, e.g., TypeScript)
# Adjust this command if your build script is different
RUN npm run build

# Stage 2: Production
FROM node:22-alpine AS production

# Set working directory
WORKDIR /app

# Copy production dependencies from the builder stage
COPY --from=builder /app/node_modules ./node_modules

# Copy the built application from the builder stage
COPY --from=builder /app/dist ./dist
# Copy environment variables file(s) to the production image


# Copy package.json (or a minimal version) to allow `npm install --production` to work if needed later
# This is often not necessary if you copy `node_modules` directly, but it's good practice
COPY package.json ./

# Expose the port the application listens on
EXPOSE 3000

# Set the command to start the application
CMD ["node", "dist/server.js"]