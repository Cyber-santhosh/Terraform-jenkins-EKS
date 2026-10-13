pipeline {
    agent {label 'buildagent'}
    environment{
        username='my-app'
        dockeruser=credentials ('dockerkey')
    }
    
    stages {
        stage('SCM checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Cyber-santhosh/Terraform-jenkins-EKS.git'
            }
        }
    stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    stage('Docker build') {
            steps {
                sh 'docker build -t $username/eks-app:${BUILD_NUMBER} .'
            }
        }
    stage('Docker login') {
            steps {
                sh 'echo $dockeruser_PSW | docker login -u $dockeruser_USR --password-stdin'
            }
        }
    stage('Docker push') {
            steps {
                sh 'docker push $username/eks-app:${BUILD_NUMBER}'
            }
        }
    stage('terraform Initalization') {
            steps {
                script {
                    dir ('EKS with terraform'){
                    sh 'terraform init'
                    }
                }            
            }
        }
    stage('terraform fmt') {
            steps {
                script {
                    dir ('EKS with terraform'){
                    sh 'terraform fmt'
                    }
                }
            }
        }
    stage('terraform validate') {
            steps {
                script {
                    dir ('EKS with terraform'){
                    sh 'terraform validate'
                    }
                }
            }
        }
    stage('terraform plan') {
            steps {
                script {
                    dir ('EKS with terraform'){
                    sh 'terraform $action -out=tfplan'
                    }
                }
            }
        }
    stage('Deploying Application') {
            steps{
                script{
                    dir('EKS/ConfigurationFiles') {
                        sh 'aws eks update-kubeconfig --name my-eks-cluster'
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'
                    }
                }
            }
        }
    }
}
