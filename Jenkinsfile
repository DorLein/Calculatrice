pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'localhost:5000/calculatrice'
        DOCKER_CONTAINER = 'calculatrice'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Compilation') {
            steps {
                sh './gradlew compileJava'
            }
        }

        stage('Test unitaire') {
            steps {
                sh './gradlew test'
            }
        }

        stage('Couverture de code') {
            steps {
                sh './gradlew jacocoTestReport'
                publishHTML(target: [
                    reportName: 'Code Coverage',
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html'
                ])
            }
        }

        stage('Analyse statique du code') {
            steps {
                sh './gradlew checkstyleMain'
                publishHTML(target: [
                    reportName: 'Checkstyle Report',
                    reportDir: 'build/reports/checkstyle',
                    reportFiles: 'main.html'
                ])
            }
        }

        stage('Package') {
            steps {
                sh './gradlew build'
            }
        }

        stage('Docker build') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Docker push') {
            steps {
                script {
                    // Push the Docker image to the registry
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to staging') {
            steps {
                script {
                    // Stop and remove any existing container
                    sh 'docker rm -f $DOCKER_CONTAINER || true'

                    // Run the container
                    sh 'docker run -d -p 8882:8081 --name $DOCKER_CONTAINER $DOCKER_IMAGE'
                }
            }
        }

        stage('Acceptance Test') {
            steps {
                script {
                    // Run the acceptance test script
                    sh './test_acceptance.sh'
                }
            }
        }
    }

    post {
        always {
            script {
                // Clean up by stopping and removing the container after the test
                sh 'docker stop $DOCKER_CONTAINER || true'
                sh 'docker rm $DOCKER_CONTAINER || true'
            }
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

