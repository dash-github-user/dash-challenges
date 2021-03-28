pipeline {
    agent any 
    stages {
        stage('Stage 1') {
            steps {
                withAWS(credentials: 'radiant-dash-aws-credentials', region: 'us-east-1') {
                    sh "aws s3 ls"
                }
            }
        }
    }
}