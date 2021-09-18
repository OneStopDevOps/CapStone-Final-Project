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
    SSH_COMMAND            = "${EC2_USER}@${EC2_ADDRESS}"
  }

  stages {

    stage('Stage 1 - Clone CapStone-Final-Project') {

      steps {
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
        // NOTE: use -E along with sudo to preserve existing environment variables
        sh "export BUILD_VERSION=${BUILD_TAG}&& sudo -E docker-compose build"
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
          withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", usernameVariable: 'HUB_USER', passwordVariable: 'HUB_TOKEN')]) {                      
            sh "sudo docker login -u $HUB_USER -p $HUB_TOKEN"
            sh "sudo docker image push ${IMAGE_NAME}:${BUILD_TAG}"
            echo "Image pushed."
          }
        }
      }
    }
  
    stage('Stage 6 - Deploy the application deployment to the production server') {

      when {
        expression {
          currentBuild.result == null || currentBuild.result == 'SUCCESS'
        }
      }

      steps {

        dir('deploy') {

          sshagent(['aws_ubuntu_user']) {
            sh "scp start.sh ${SSH_COMMAND}:/home/${EC2_USER}"
            sh "scp shutdown.sh ${SSH_COMMAND}:/home/${EC2_USER}"
            sh "ssh -X ${SSH_COMMAND} export BUILD_TAG=${BUILD_TAG}"
            sh "ssh -X ${SSH_COMMAND} cd /home/${EC2_USER}"
            sh "ssh -X ${SSH_COMMAND} chmod +x start.sh shutdown.sh"
            sh "ssh -X ${SSH_COMMAND} ./start.sh ${BUILD_TAG}"
            echo "Image deployed."
          }
        }
      }
    }

  }

  post {
  
    success {
      echo "Build completed."
    }

    failure {
      echo "Build failed."
    }
    
  }

}