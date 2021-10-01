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
  }
}
