aws cloudformation --profile voathnakl delete-stack --stack-name vlim-swagger-app-stack --region us-east-1
aws s3 --profile voathnakl rb s3://vlim-swagger-app-bucket --region us-east-1 --force