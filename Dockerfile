FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY hello.java .
RUN javac hello.java
CMD ["java", "hello"]
