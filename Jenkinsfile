pipeline {

  agent any 
  environment {
	  DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred-raj')
	}

  parameters {
    string defaultValue: 'master', name: 'branch_name'
    choice choices: ['DEV', 'SIT', 'UAT', 'PREPROD'], name: 'environment'
  }

  triggers {
    cron '30 20 * * *'
  }

  options {
    buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
    disableConcurrentBuilds()
    timestamps()
    parallelsAlwaysFailFast()
  }

  stages {
    stage ('Code Checkout'){
      steps {
        git credentialsId: 'github-credentials', url: 'https://github.com/yoyo143/counter-app.git'
      }
    }
    stage ('npm install'){
      steps {
        sh "npm install"
      }
    }

    stage ('Docker Image Build'){
      steps {
        sh '''
          tag=`git log --format="%H" -n 1 | cut -c 1-7`
          sudo docker image build -t mycounterapp:${tag}${BUILD_ID} .
        '''
      }
    }
   stage ('Docker login'){
      steps{
       
      sh "docker login -u rajendrakumarm -p Mummy@7865"
      
      
    }
  }
   stage ('Docker Tag and Push'){
      steps {
        sh '''
          tag=`git log --format="%H" -n 1 | cut -c 1-7`
          sudo docker image tag mycounterapp:${tag}${BUILD_ID} rajendrakumarm/devops:${tag}${BUILD_ID}
          sudo docker push rajendrakumarm/devops:${tag}${BUILD_ID}
	  '''   
	  }
	}
   stage ('Docker Deployment'){
      steps{
        sh '''
          
	  tag=`git log --format="%H" -n 1 | cut -c 1-7`
	  docker run -i rajendrakumarm/devops:${tag}
	  
          '''
     }
   }

  }
}
