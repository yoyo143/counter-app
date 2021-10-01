pipeline {

  agent {
    label 'jenkins-worker-1'
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
        git credentialsId: 'github-credentials', url: 'https://github.com/gkdevops/counter-app.git'
      }
    }
    stage ('npm install'){
      steps {
        sh "npm install"
      }
    }
    stage ('create build'){
      steps {
        sh "npm run build"
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
  }
}
