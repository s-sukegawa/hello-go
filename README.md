# AWS App Runner Setup and Usage

## Overview
AWS App Runner is a fully managed service that makes it easy for developers to quickly deploy containerized web applications and APIs at scale.

## Prerequisites
- An AWS account.
- AWS CLI installed and configured.
- Familiarity with Docker and containerization.

## Steps to Deploy a Containerized Application

### 1. Create a Dockerfile
Create a `Dockerfile` for your application. Here’s an example:
```Dockerfile
# Use an official Go runtime as a parent image
FROM golang:1.16

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go Modules manifests
COPY go.mod .
COPY go.sum .

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are unchanged
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go app
RUN go build -o main .

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
``` 

### 2. Build Your Docker Image
Run the following command in your terminal:
```bash
docker build -t my-app .
```

### 3. Push the Docker Image to Amazon ECR
- First, create an Amazon ECR repository:
```bash
aws ecr create-repository --repository-name my-app
```
- Authenticate Docker to the ECR registry:
```bash
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```
- Tag your image:
```bash
docker tag my-app:latest <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/my-app:latest
```
- Push the image to the ECR repository:
```bash
docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/my-app:latest
```

### 4. Create an App Runner Service
- Go to the AWS Management Console.
- Navigate to App Runner and click on “Create service”.
- Choose to deploy from an ECR repository and select your repository and tag.
- Configure any additional settings, such as instance size and auto-scaling.
- Click “Create and Deploy”.

## Conclusion
Your application is now running on AWS App Runner! You can access it using the provided URL in the App Runner console.