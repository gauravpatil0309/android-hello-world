@Library('My-Jenkins_SharedLibrary@master')_

pipeline {
  agent any
  
  //environment {
       // APP_CENTER_API_TOKEN = '1ef2e87676923623ff3a7cfc87838b357579aaa3'
       // APP_CENTER_OWNER_NAME = 'gaurav.patil0309-gmail.com'
       // APP_CENTER_APP_NAME = 'latest'
       // APK_FILE_PATH = '/var/lib/jenkins/workspace/android-app/app/build/outputs/apk/debug/app-debug.apk'
  //}
  stages {
    stage('Install Dependencies') {
      steps {
        installGradleJava()
      }
    }
    
    stage("Git Checkout") {
            steps {
                git branch: 'master',
                url: "https://github.com/gauravpatil0309/android-hello-world.git"
            }
        }
  
    stage('Build') {
       steps {
           buildAndroidApp()
          }
        } 
        
    stage('Publish') {
      environment {
        APPCENTER_API_TOKEN = credentials('API-Token')
    }
        steps {
            appCenter apiToken: APPCENTER_API_TOKEN,
            ownerName: 'gaurav.patil0309-gmail.com',
            appName: 'latest',
            pathToApp: '**/*.apk',
            distributionGroups: 'testgroup'
           }
        }    
    } 
}    
    //post {
        //success {
           // script {
                // Upload the .apk file to App Center on build success
                //sh "curl -X POST -H 'Content-Type: multipart/form-data' -H 'X-API-Token: 1ef2e87676923623ff3a7cfc87838b357579aaa3' -F 'file=/var/lib/jenkins/workspace/android-app/app/build/outputs/apk/debug/app-debug.apk' 'https://appcenter.ms/users/gaurav.patil0309-gmail.com/apps/latest'"
            //}
       // }
    //}
