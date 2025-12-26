pipeline {
    agent any

    environment {
        IMAGE_NAME = "proj3-im"
        DEV_REPO  = "kowsik140602/dev"
        PROD_REPO = "kowsik140602/prod"
    }

    stages {

        stage("Build docker image") {
            steps {
                sh "chmod +x build.sh"
                sh "./build.sh"
            }
        }

        stage("Docker login") {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: "docker-cred",
                        usernameVariable: "DOCKER-USER",
                        passwordVariable: "DOCKER-PSWD"
                    )
                ]) {
                    sh 'echo $DOCKER-PSWD | docker login -u $DOCKER-USER --password-stdin'
                }
            }
        }

        stage("Push image based on branch") {
            steps {
                script {

                    if (env.BRANCH_NAME == 'dev') {
                        echo "Pushing image to DEV repo"
                        sh """
                            docker tag $IMAGE_NAME $DEV_REPO:latest
                            docker push $DEV_REPO:latest
                        """
                    }

                    if (env.BRANCH_NAME == 'master') {
                        echo "Pushing image to PROD repo"
                        sh """
                            docker tag $IMAGE_NAME $PROD_REPO:latest
                            docker push $PROD_REPO:latest
                        """
                    }

                }
            }
        }
        
        stage('Deploy to Dev Environment') {
            when {
                branch 'dev'
            }
            steps {
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully for ${env.BRANCH_NAME}"
        }
        failure {
            echo "Pipeline failed for ${env.BRANCH_NAME}"
        }
    }
}
