ipeline {
     agent any
 
     environment {
         IMAGE_NAME = "muruganpm/onlinebookstore"
         CONTAINER_NAME = "onlinebookstore-container"
         HOST_PORT = "8081"
         DOCKER_IMAGE = 'pmmurugan798/onlinebookstore:latest'
     }
 
     stages {
         stage('Build Docker Image') {
         stage('Docker Login') {
             steps {
                 script {
                     echo "Building Docker image using multi-stage build..."
                     sh 'docker build -t ${IMAGE_NAME} .'
                 withCredentials([usernamePassword(credentialsId: 'dockerhub', 
                                                  usernameVariable: 'DOCKERHUB_USER', 
                                                  passwordVariable: 'DOCKERHUB_TOKEN')]) {
                     sh 'echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USER" --password-stdin'
                 }
             }
         }
 
         stage('Run Container') {
         stage('Build & Push Image') {
             steps {
                 script {
                     echo "Stopping old container if it exists..."
                     sh "docker rm -f ${CONTAINER_NAME} || true"
 
                     echo "Running new container..."
                     sh "docker run -d -p ${HOST_PORT}:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                 }
                 sh '''
                 docker build -t $DOCKER_IMAGE .
                 docker push $DOCKER_IMAGE
                 '''
             }
         }
     }
 
     post {
         success {
             echo "✅ App running at http://localhost:${HOST_PORT}/onlinebookstore"
         }
         failure {
             echo "❌ Something went wrong!"
         }
     }
 }
