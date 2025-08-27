FROM openjdk:17-jdk-alpine
LABEL maintainer="Bektur Mambetov"

# Install Node.js for Angular frontend build
RUN apk add --no-cache nodejs npm yarn curl

WORKDIR /usr/app

# Copy the project and build it
COPY . .

# Set Node.js options to fix OpenSSL compatibility issue
ENV NODE_OPTIONS="--openssl-legacy-provider --max_old_space_size=4096"

# Build the application
RUN cd /usr/app && mvn clean package -DskipTests

# Copy the built jar
RUN cp /usr/app/opencbs-server/target/*.jar /usr/app/opencbs-server.jar

# Create directories for file storage
RUN mkdir -p /app/data/attachments /app/data/templates

# Use the main application.properties created in the PR
COPY ./opencbs-server/src/main/resources/application.properties /usr/app/application.properties

# Expose port
EXPOSE 8080

CMD ["java", "-jar", "/usr/app/opencbs-server.jar", "-Djava.security.egd=file:/dev/./urandom", "-Dspring.config.location=/usr/app/application.properties"]

