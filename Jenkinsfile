pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git 'https://github.com/SriramVeldandi/DevOps.git'
            }
        }
        stage('Removing Docker image and container') {
            steps {
                script {
                    sh 'docker rmi -f sriram2421/html-app:latest'
                    sh 'docker stop html-app-container'
                    sh 'docker rm html-app-container'
                }
            }
        }
        stage('Building new Docker image and container') {
            steps {
                script {
                    sh 'docker build -t sriram2421/html-app:latest .'
                    sh 'docker run -itd -p 85:80 --name html-app-container sriram2421/html-app:latest'
                }
            }
        }
        stage('Inserting image into dockerhub') {
            steps {
                withCredentials([usernamePassword(credentialsId:'Docker-login', usernameVariable: 'DockerUsername', passwordVariable: 'DockerPassword')]){
                    script {
                        sh 'docker login -u ${DockerUsername} -p ${DockerPassword}'
                        sh 'docker push sriram2421/html-app:latest'
                    }
                }
            }
        }
        stage('Deploying image in Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                    sh 'kubectl set image deployment my-app-deployment my-app-container=sriram2421/html-app:latest --record'
                    sh 'kubectl rollout restart deployment my-app-deployment'
                    sh 'kubectl rollout status deployment my-app-deployment'
                    sh 'kubectl get services'
                }
            }
        }
    }
}
