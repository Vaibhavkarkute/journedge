FROM node:20-alpine

# Install OpenSSL required by Prisma schema engine on Alpine Linux
RUN apk add --no-cache openssl libc6-compat

WORKDIR /app

# Copy all project files into the container
COPY . .

# Expose port 3000
EXPOSE 3000

# Set environment variables so Next.js binds to 0.0.0.0
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# 1. Ensure .env exists
# 2. Install dependencies
# 3. Run Prisma migrations
# 4. Start Next.js dev server explicitly bound to 0.0.0.0
CMD sh -c "cp -n .env.example .env || true && npm install && npx prisma migrate dev --name init && npm run dev -- -H 0.0.0.0 -p 3000"