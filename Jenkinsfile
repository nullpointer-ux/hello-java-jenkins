pipeline {
    agent any 

    stages {
        stage('Build') { 
            steps {
                // Image banana (Compile Dockerfile)
                sh 'docker build -t my-app .' 
            }
        }
        stage('Run') { 
            steps {
                // Image chalana (Execute inside Container)
                sh 'docker run --rm my-app'
            }
        }
    }
}
