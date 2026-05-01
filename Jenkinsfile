pipeline {
    agent any 

    environment {
        // Replace 'your-docker-id' with your actual Docker Hub username
        DOCKER_HUB_USER = 'null123pointer'
        APP_NAME = 'my-app'
        IMAGE_TAG = "${env.BUILD_ID}" // Uses Jenkins build number as version
    }

    stages {
        stage('Build') { 
            steps {
                // We tag it with the full Docker Hub path immediately
                sh "docker build -t ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG} ." 
            }
        }
        
        stage('Push to Dockerhub') { 
            steps {
                // This block safely retrieves your stored login info
                withCredentials([usernamePassword(credentialsId: 'my-docker-hub-credentials-id', 
                                                 usernameVariable: 'DOCKER_USERNAME', 
                                                 passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh """
                    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    docker push ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }
    }
    

}











// pipeline {
//     agent any 

//     stages {
//         stage('Build') { 
//             steps {
//                 // Image banana (Compile Dockerfile)
//                 sh 'docker build -t my-app .' 
//             }
//         }
//         stage('Run') { 
//             steps {
//                 // Image chalana (Execute inside Container)
//                 sh 'docker run --rm my-app'
//             }
//         }
//     }
// }
