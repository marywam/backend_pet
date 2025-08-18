pipeline {
    
    agent any 

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
                    python3 -m venv venv
                    source venv/bin/activate
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