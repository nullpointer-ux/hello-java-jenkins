pipeline {
    agent any

    stages {
        stage('Check Kubernetes') {
            steps {
                sh '/usr/local/bin/kubectl get nodes'
            }
        }

        stage('Deploy') {
            steps {
                sh '/usr/local/bin/kubectl apply -f deployment.yaml'
            }
        }
    }
}
