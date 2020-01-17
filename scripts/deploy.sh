#!/usr/bin/env bash

APP_NAME=vlim-swagger-app
S3_BUCKET=$APP_NAME-bucket
INPUT_FILE=template.yaml
OUTPUT_FILE=packaged.yaml
STAGE_NAME=dev
STACK_NAME=$APP_NAME-$STAGE_NAME-stack
PROFILE=voathnakl
REGION=us-east-1


aws s3api 	--profile $PROFILE create-bucket \
			--bucket $S3_BUCKET \
			--region $REGION

# Copy Swagger file to S3 to be able to transform its content for "deploying" it to API Gateway
aws s3 	--profile $PROFILE \
		--region $REGION \
		cp swagger.yaml s3://$S3_BUCKET/swagger.yaml

sam package --profile $PROFILE \
			--template-file $INPUT_FILE \
			--output-template-file $OUTPUT_FILE \
			--s3-bucket $S3_BUCKET

sam deploy 	--profile $PROFILE \
			--region $REGION \
			--template-file $OUTPUT_FILE \
			--stack-name $STACK_NAME \
			--parameter-overrides \
				StageName=$STAGE_NAME \
				S3BucketName=$S3_BUCKET \
			--capabilities CAPABILITY_IAM

export API_GATEWAY_URL=$( \
aws cloudformation describe-stacks \
					--profile $PROFILE \
					--region $REGION \
					--stack-name $STACK_NAME \
					--query 'Stacks[0].Outputs[0].OutputValue' \
					--output text \
)

echo "API Gateway URL: $API_GATEWAY_URL"
