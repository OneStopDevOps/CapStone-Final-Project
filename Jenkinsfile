pipeline {

  agent {label 'slave-node-1'}

  tools {
    maven 'mvn'
  }

  environment {
	  GIT_REPO_URL           = 'https://github.com/OneStopDevOps/CapStone-Final-Project.git'

    IMAGE_NAME             = 'onestopdevops/capstone-final-project'
    DOCKER_COMPOSE_FILE    = 'docker-compose.yml'
    DOCKERHUB_CREDENTIALS  = 'onestopdevops-docker-hub-user'

    PATH                   = "$PATH:/usr/bin"
  }

  stages {

    stage('Stage 1 - Clone CapStone-Final-Project') {

      steps {

        //sendStartNotification()

        echo "Checking out from github repo..."
        git branch: 'main', url: "${GIT_REPO_URL}"
      }
    }

    stage('Stage 2 - Executing unit testing suite') {

      // only execute this stage if the previous stages are successful.
      when {
        expression {
          currentBuild.result == null || currentBuild.result == 'SUCCESS'
        }
      }

      steps {
         echo "Execute unit testing for inventory-service ..."

         dir('inventory-service') {
          sh 'pwd'
          sh 'mvn test'
         }
		   
         echo "Publishing junit test results..."
		 	
	      junit(
		      allowEmptyResults: true,
		      testResults: 'inventory-service/target/surefire-reports/*.xml'
	      )
      }
    }
 
    stage('Stage 3 - Build the inventory-service jar') {

      // only execute this stage if the previous stages are successful.
      when {
        expression {
          currentBuild.result == null || currentBuild.result == 'SUCCESS'
        }
      }

      steps {

        echo "Building inventory-service war file ..."
        dir('inventory-service') {
          sh 'pwd'
          sh 'mvn clean package'
        }
      }
    }

    stage('Stage 4 - Build the docker image') {

      when {
        expression {
          currentBuild.result == null || currentBuild.result == 'SUCCESS'
        }
      }

      steps {

        echo "Creating inventory-service image..."
        sh "export BUILD_VERSION=${BUILD_TAG}&& docker-compose build"
      }
    }

    stage('Stage 5 - Publish the docker image to DockerHub') {

      when {
        expression {
          currentBuild.result == null || currentBuild.result == 'SUCCESS'
        }
      }

      steps {

        script {
          echo "Uploading docker image to DockerHub"
          docker.withRegistry('', "${DOCKERHUB_CREDENTIALS}") {
          
            //push image
            sh "export BUILD_VERSION=${BUILD_TAG}&& docker-compose -f ${env.DOCKER_COMPOSE_FILE} push"
            echo "Image pushed."
          }
        }
      }
    }

    /*stage('Stage 4 - Deploy to tomcat container on AWS EC2...') {
      
      // only execute this stage if the previous stages are successful.
      when {
        expression {
          currentBuild.result == null || currentBuild.result == 'SUCCESS'
        }
      }

      steps {
	    echo "Deploying war to tomcat container."
	    
	    dir('inventory-service/target') {
	        sshagent(['jenkins-ssh-ec2-user']) {
				sh "scp inventory-service.war ${EC2_USER}@${EC2_ADDRESS}:/home/${EC2_USER}/apache-tomcat-9.0.46/webapps"
			}
	    }
      } 
    }*/

  }

  post {
  
    success {
      echo "Build completed."
      //sendSuccessNotification()
    }

    failure {
      echo "Build failed."
      //sendFailNotification()
    }
    
  }

}

/*
   Send out start build event notification thru email
*/
def sendStartNotification() {

  emailext( 
    subject: "STARTED Job: '${env.JOB_NAME} [${env.JOB_NUMBER}]'",
    body: """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
      <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
    to: '$DEFAULT_RECIPIENTS',
    recipientProviders: [[$class: 'DevelopersRecipientProvider']] 
  )
}

/*
  Send out fail build event notification thru email
*/
def sendFailNotification() {

  emailext (
    subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
    body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
      <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
    to: '$DEFAULT_RECIPIENTS',
    recipientProviders: [[$class: 'DevelopersRecipientProvider']]
  )
}

/*
  Send out success build event notification thru email
*/
def sendSuccessNotification() {

  emailext (
    subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
    body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
      <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
    to: '$DEFAULT_RECIPIENTS',
    recipientProviders: [[$class: 'DevelopersRecipientProvider']]
  )
} 