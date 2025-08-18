pipeline {
    agent none   // 👈 default to none, then define agents per stage

    stages {

        stage("Checkout") {
            agent any
            steps {
                checkout scm
            }
        }

        // For feature branches (dev, marystage, feature-*)
        stage("Build & Test (Parallel)") {
            when {
                anyOf {
                    branch pattern: "feature-.*", comparator: "REGEXP"
                    branch "dev"
                    branch "marystage"
                }
            }
            parallel {
                stage("Build") {
                    agent {
                        docker {
                            image 'python:3.11-slim'
                            args '-u root'
                        }
                    }
                    steps {
                        echo "🔨 Building the project...."
                    }
                }
                stage("Test") {
                    agent {
                        docker {
                            image 'python:3.11-slim'
                            args '-u root'
                        }
                    }
                    steps {
                        echo "🧪 Running the tests...."
                        sh '''
                            cd ecommerce
                            pip install --upgrade pip
                            pip install -r requirements.txt
                            python manage.py test
                        '''
                    }
                }
            }
        }

        // For master only
        stage("Build") {
            when { branch "master" }
            agent {
                docker {
                    image 'python:3.11-slim'
                    args '-u root'
                }
            }
            steps {
                echo "🔨 Building on master branch...."
            }
        }

        stage("Test") {
            when { branch "master" }
            agent {
                docker {
                    image 'python:3.11-slim'
                    args '-u root'
                }
            }
            steps {
                echo "🧪 Running tests on master...."
                sh '''
                    cd ecommerce
                    pip install --upgrade pip
                    pip install -r requirements.txt
                    python manage.py test
                '''
            }
        }

        stage("Docker Build") {
            when { branch "master" }
            agent any   // 👈 run on Jenkins node with Docker
            steps {
                echo "🐳 Building Docker image...."
                sh "docker build -t marywam/pet_app:latest ."
            }
        }

        stage("Docker Push") {
            when { branch "master" }
            agent any   // 👈 run on Jenkins node with Docker
            steps {
                echo "📤 Pushing Docker image...."
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push marywam/pet_app:latest
                    '''
                }
            }
        }

        stage("Docker Cleanup") {
            when { branch "master" }
            agent any   // 👈 run on Jenkins node with Docker
            steps {
                echo "🧹 Cleaning up unused Docker images...."
                sh 'docker image prune -af'
            }
        }

        stage("Deploy") {
            when { branch "master" }
            agent any   // 👈 run on Jenkins node with Docker
            steps {
                echo "🚀 Deploying the project...."
                // add your AWS EC2/ECS deploy commands here
            }
        }
    }
}
