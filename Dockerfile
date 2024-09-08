# Use an Alpine-based Node.js image
FROM node:lts-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available) separately
COPY package*.json ./

# Install production dependencies only
RUN npm install --production

# Copy only necessary files to the container
COPY . .

# Set the default command to run the application
CMD ["node", "index.js"]
