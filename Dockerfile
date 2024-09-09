# Use an Alpine-based Node.js image
FROM node:alpine

# Set environment variables for the timezone
ENV TZ=America/Chicago

# Install required packages and timezone data
RUN apk --no-cache add tzdata && \
    mkdir -p /app/storage && \
    chown -R node:node /app

# Set working directory and copy package.json for dependency installation
WORKDIR /app
COPY ./package.json ./
RUN npm cache clean --force && \
    npm install --omit=dev

# Copy the rest of the application source code
COPY ./src/ /app/

# Set environment variables for the application
ENV ASF_PROTOCOL=http \
    ASF_HOST=localhost \
    ASF_PORT=1242 \
    ASF_PASS=secret \
    ASF_COMMAND_PREFIX=! \
    ASF_BOTS=asf \
    ASF_CLAIM_INTERVAL=6 \
    WEBHOOK_URL=none \
    WEBHOOK_ENABLEDTYPES=error;warn;success \
    WEBHOOK_SHOWACCOUNTSTATUS=true

# Switch to the non-root user and set the default command
USER node
CMD ["node", "index.js"]
