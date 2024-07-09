# Build the application
FROM maven:3.9.8-openjdk-22 AS builder
WORKDIR /construct/seller
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Create the final image
FROM openjdk:22-jdk
WORKDIR /construct/seller
COPY --from=builder /construct/seller/target/seller-api.jar seller-api.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "seller-api.jar"]