pipeline {
    agent any

    parameters {
        string(
            name: 'AMI_ID',
            defaultValue: '',
            description: 'Valid AMI ID for ap-south-1'
        )

        string(
            name: 'SUBNET_ID',
            defaultValue: '',
            description: 'Existing AWS subnet ID'
        )
    }

    environment {
        AWS_REGION = 'ap-south-1'
        TF_IN_AUTOMATION = 'true'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Version') {
            steps {
                sh 'terraform -version'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Terraform Format Check') {
            steps {
                sh 'terraform fmt -check -recursive'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                    set -eu

                    test -n "$AMI_ID"
                    test -n "$SUBNET_ID"

                    terraform plan \
                      -input=false \
                      -no-color \
                      -out=tfplan \
                      -var="ami_id=$AMI_ID" \
                      -var="subnet_id=$SUBNET_ID"
                '''
            }
        }

        stage('Approve Infrastructure Changes') {
            steps {
                input message: 'Review the Terraform plan and approve infrastructure creation?',
                      ok: 'Approve'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -input=false -no-color tfplan'
            }
        }

        stage('Terraform Outputs') {
            steps {
                sh 'terraform output'
            }
        }
    }

    post {
        success {
            echo 'Terraform pipeline completed successfully.'
        }

        failure {
            echo 'Terraform pipeline failed. Review the Jenkins Console Output.'
        }

        always {
            echo 'Terraform pipeline execution finished.'
        }
    }
}
