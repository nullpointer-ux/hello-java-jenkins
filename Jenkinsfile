pipeline {
    agent any 

    environment {
        DOCKER_HUB_USER = 'null123pointer'
        APP_NAME = 'hello-app'
        IMAGE_TAG = "${env.BUILD_ID}" 
    }

    stages {
        stage('Build') { 
            steps {
                sh "docker build -t ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG} ." 
            }
        }
        
        stage('Push to Dockerhub') { 
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', 
                                                 usernameVariable: 'DOCKER_USERNAME', 
                                                 passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin'
                    sh "docker push ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy to K8s') {
            steps {
                // This connects Jenkins to your K8s cluster
                withCredentials([file(credentialsId: 'k8s-config', variable: 'KUBECONFIG')]) {
                    sh """
                    # 1. Update the YAML file with the current Build ID
                    sed -i 's/BUILD_NUMBER/${IMAGE_TAG}/g' k8s-deploy.yaml
                    
                    # 2. Tell Kubernetes to apply the changes
                    kubectl apply -f k8s-deploy.yaml --kubeconfig=${KUBECONFIG}
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                withCredentials([file(credentialsId: 'k8s-config', variable: 'KUBECONFIG')]) {
                    sh """
                    # Check if the pods are running
                    kubectl get pods --kubeconfig=${KUBECONFIG}
                    
                    # Wait for the deployment to finish successfully
                    kubectl rollout status deployment/hello-app-deployment --kubeconfig=${KUBECONFIG}
                    """
                }
            }
        }
    }

    post {
        always {
            sh "docker rmi ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG} || true"
        }
    }
}
