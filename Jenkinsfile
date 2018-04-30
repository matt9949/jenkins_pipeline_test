#!/usr/bin/env groovy
pipeline {
  agent any

  stages {
      stage('docker build') {
        when{
          branch 'integration' || checkIfCommitIsAMergeRequestToMaster()
        }
        steps {
          sh 'make build'
        }
      }

      stage('docker run') {
        when{
          checkIfCommitIsAMergeRequestToMaster() || branch 'master'
        }
        steps {
          sh 'make run'
        }
      }

      stage('run test') {
        when{
          checkIfCommitIsAMergeRequestToMaster()
        }
        steps {
          script{
            def response = httpRequest 'http://localhost:5000'
			         if (response.content.equals('Hello World!') {
				         println("App successfully deployed and tested.")
			         }
               else {
				         error("Application has failed test. Failing build. Error:" + response)
			      }
          }
        }
      }
  }

  def checkIfCommitIsAMergeRequestToMaster(){
    sh 'git log --format=%B -n 1 HEAD > commitMessage'
    def commitMessage = readFile('commitMessage')
    sh 'rm commitMessage'
    return env.BRANCH_NAME.equals('master') && commitMessage.startsWith('Merge pull request'))
  }
}
