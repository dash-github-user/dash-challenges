pipeline {
    agent any 
    stages {
        stage('Mock Deploy') {
            steps {
                withAWS(credentials: 'radiant-dash-aws-credentials', region: 'us-east-1') {
                    sh "aws s3 ls"
                }
            }
        }
    }
}