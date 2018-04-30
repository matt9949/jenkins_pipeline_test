#!/usr/bin/env groovy
pipeline {
  agent none

  stages {
      stage('docker build') {
        steps {
          make build
        }
      }
  }
}
