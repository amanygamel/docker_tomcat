pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'java-tomcat-image'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the version control system (e.g., Git)
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    def container = docker.run(DOCKER_IMAGE, '-p 8080:8080')

                    // Optionally, you can add more steps to interact with the running container
                }
            }
        }
    }

    post {
        always {
            // Clean up the workspace
            cleanWs()
        }

        success {
            echo 'Build and run successful!'
        }

        failure {
            echo 'Build or run failed!'
        }
    }
}
