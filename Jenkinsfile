pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'java-tomcat-japanese'
        DOCKER_TAG = 'latest'
        DOCKER_REGISTRY_URL = 'https://index.docker.io/v1/'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amanygamel/docker_tomcat.git', credentialsId: '90406132-0908-4605-81c0-dc78b1657819'
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    docker.withRegistry("${env.DOCKER_REGISTRY_URL}", 'docker-hub-credentials') {
                        echo 'Logged in to Docker Hub'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def app = docker.build("${env.DOCKER_IMAGE}:${env.DOCKER_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("${env.DOCKER_REGISTRY_URL}", 'docker-hub-credentials') {
                        docker.image("${env.DOCKER_IMAGE}:${env.DOCKER_TAG}").push()
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker images'
            }
        }
        cleanup {
            cleanWs()
        }
    }
}
