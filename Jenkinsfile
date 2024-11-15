pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'localhost:5000/calculatrice'
        DOCKER_CONTAINER_NAME = 'calculatrice'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Compilation') {
            steps {
                script {
                    sh './gradlew compileJava'
                }
            }
        }

        stage('Test unitaire') {
            steps {
                script {
                    sh './gradlew test'
                }
            }
        }

        stage('Couverture de code') {
            steps {
                script {
                    sh './gradlew jacocoTestReport'
                    publishHTML(target: [
                        reportName: 'Code Coverage',
                        reportDir: 'build/reports/jacoco/test/html',
                        reportFiles: 'index.html'
                    ])
                }
            }
        }

        stage('Analyse statique du code') {
            steps {
                script {
                    sh './gradlew checkstyleMain'
                    publishHTML(target: [
                        reportName: 'Checkstyle Report',
                        reportDir: 'build/reports/checkstyle',
                        reportFiles: 'index.html'
                    ])
                }
            }
        }

        stage('Package') {
            steps {
                script {
                    sh './gradlew build'
                }
            }
        }

        stage('Docker build') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Docker push') {
            steps {
                script {
                    sh 'docker push ${DOCKER_IMAGE}'
                }
            }
        }

        stage('Deploy to staging') {
            steps {
                script {
                    // Remove existing container if any
                    sh 'docker rm -f ${DOCKER_CONTAINER_NAME} || true'
                    // Run the container
                    sh 'docker run -d -p 8882:8081 --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE}'
                    // Give the container some time to start
                    sleep 30  // Wait 30 seconds to allow the service to start
                }
            }
        }

        stage('Acceptance Test') {
            steps {
                script {
                    sh './acceptance_test.sh'
                }
            }
        }
    }

    post {
        always {
            script {
                // Clean up Docker container after testing
                sh 'docker stop ${DOCKER_CONTAINER_NAME} || true'
                sh 'docker rm ${DOCKER_CONTAINER_NAME} || true'
            }
        }
    }
}

