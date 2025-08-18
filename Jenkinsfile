pipeline {
    
    agent {
        docker {
            image 'python:3.11-slim'
            args '-u root'  // ensures you can install extra packages if needed
        }
    }

    stages {

        stage("Checkout") {
            steps {
                checkout scm   // 👈 pulls your repo into the workspace
            }
        }

        stage("build") {

            steps {
                echo "Building the project...."
                
            }
        }

        stage("test") {

            steps{
                echo "Running the tests...."
                 sh '''
                     cd ecommerce
                     pip install --upgrade pip
                     pip install -r requirements.txt
                     python manage.py test
                '''
            }
        }

        stage("deploy") {
            when {
                anyOf {
                    branch 'master'
                }
            }
            steps{
                echo "Deploying the project...."
            }
        }
    }
}