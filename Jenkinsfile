pipeline {
  agent any
  environment {
        AWS_ACCOUNT_ID     = credentials('jenkins-aws-account-id')
  }
  stages {
    stage('build docker image and tag') {
      steps {
        sh 'sudo docker build -t portal .'
      }
    }
    stage('ecr push') {
      steps {
        sh '''eval sudo $(aws ecr get-login --no-include-email --region us-west-2)
latest_tag=$(aws ecr describe-images --repository-name portal --region us-west-2  --output text --query \'sort_by(imageDetails,& imagePushedAt)[*].imageTags[*]\' | tr \'\\t\' \'\\n\'  | tail -1)
if [ -z ${latest_tag} ]; then
  VERSION_TAG=1.0.0
else
  VERSION_TAG="${latest_tag%.*}.$((${latest_tag##*.}+1))"
fi
sudo docker tag portal $AWS_ACCOUNT_ID.dkr.ecr.us-west-2.amazonaws.com/portal:${VERSION_TAG}
sudo docker push $AWS_ACCOUNT_ID.dkr.ecr.us-west-2.amazonaws.com/portal:${VERSION_TAG}'''
      }
    }
  }
  triggers {
    pollSCM('* * * * *')
  }
}
