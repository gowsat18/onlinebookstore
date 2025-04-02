pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'gowsat18/onlinebookstore:latest'
    }
    stages {
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', 
                                                 usernameVariable: 'DOCKERHUB_USER', 
                                                 passwordVariable: 'DOCKERHUB_TOKEN')]) {
                    sh 'echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USER" --password-stdin'
                }
            }
        }
        stage('Build & Push Image') {
            steps {
                sh '''
                docker build --no-cache -t $DOCKER_IMAGE .
                docker push $DOCKER_IMAGE
                '''
            }
        }
    }
}
