pipeline {
    agent any 

    environment {
        // Your Docker Hub username
        DOCKER_HUB_USER = 'null123pointer'
        APP_NAME = 'hello-app'
        IMAGE_TAG = "${env.BUILD_ID}" 
    }

    stages {
        stage('Build') { 
            steps {
                // Building the image locally
                sh "docker build -t ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG} ." 
            }
        }
        
        stage('Push to Dockerhub') { 
            steps {
                withCredentials([usernamePassword(credentialsId: 'my-docker-hub-credentials-id', 
                                                 usernameVariable: 'DOCKER_USERNAME', 
                                                 passwordVariable: 'DOCKER_PASSWORD')]) {
                    // We use single quotes for the echo to prevent password leakage or errors
                    sh 'echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin'
                    sh "docker push ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        always {
            // Good practice: remove the image from the Jenkins server to save space
            sh "docker rmi ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG} || true"
        }
    }
}
