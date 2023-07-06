pipeline{
    agent any
    
    environment{
        dockerImage = ''
        registry = 'priyankalokesh/docker-fastapi-test'
    }
    
    stages{
        stage('ckeckout'){
        steps{
            checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Priyanka-lokesh/docker-fastapi-test.git']])
        }
        }
        stage('Build dockerImage'){
            steps{
                script{
                    dockerImage = docker.build registry
                }
            }
        }
        stage('Uploading Image') {
    steps {
        script {
            // Upload Docker image
            withDockerRegistry(credentialsId: 'Docker-Credentials', url: '') {
                def imageName = "priyankalokesh/docker-fastapi-test"
                def imageTag = "latest"
                docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                    dockerImage.push("${imageName}:${imageTag}")
                }
            }
        }
    }
}

stage('Setup Prometheus & Grafana') {
    steps {
        script {
            sh 'docker-compose -f docker-compose.monitoring.yml up -d'
        }
    }
}

stage('Run Docker Compose') {
    steps {
        script {
            sh 'docker-compose up -d'
        }
    }
}
}

post {
always {
    script {
        sh 'docker-compose down'
        sh 'docker-compose -f docker-compose.monitoring.yml down'
    }
}
}
}