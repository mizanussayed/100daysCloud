# Day 28: Creating a Private ECR Repository

## 🎯 task:
- Create a private ECR repository named `xfusion-ecr`. 
- There is a Dockerfile under `/root/pyapp` directory on aws-client host, build a docker image using this Dockerfile
- push the same to the newly created ECR repo, the image tag must be latest.

## 🧑‍💻 solution:
1. Create a private ECR repository named `xfusion-ecr`:
   ```bash
   aws ecr create-repository --repository-name xfusion-ecr --region us-east-1
   ```

2. Build a Docker image using the Dockerfile:
   ```bash
   docker build -t xfusion-ecr .
   ```
3. tag the Docker image for ECR:
   ```bash
   docker tag xfusion-ecr:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/xfusion-ecr:latest
   ```

5. Authenticate Docker to the ECR registry:
   ```bash
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
   ```
4. Push the Docker image to the ECR repository:
   ```bash
   docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/xfusion-ecr:latest
   ```
