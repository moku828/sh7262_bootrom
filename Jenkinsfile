pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        git(url: 'https://github.com/moku828/sh7262_bootrom', branch: 'sh2a_isa_test')
        sh 'make'
      }
    }
  }
}