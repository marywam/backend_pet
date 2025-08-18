pipeline {
    
    agent {
        docker {
            image 'python:3.11-slim'
            args '-u root'  // ensures you can install extra packages if needed
        }
    }

    stages {

        stage("build") {

            steps {
                echo "Building the project...."
                
            }
        }

        stage("test") {

            steps{
                echo "Running the tests...."
                 sh '''
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