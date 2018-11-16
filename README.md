### To package lambda
```
$ zip lambda.zip ./lambda/main.js
```

### Create S3 bucket from lambda package
```
$ aws s3api create-bucket --bucket=<YOUR_BUCKET_NAME> --region=<YOUR_REGION>
```

### Upload lambda package to S3
```
$ aws s3 cp lambda.zip s3://<YOUR_BUCKET_NAME/v1.0.0/lambda.zip
```

### To spin up enviroment
```
$ terraform apply -var="app_version=1.0.0"
```

### To update lambda function
```
$ aws s3 cp lambda.zip s3://<YOUR_BUCKET_NAME/v1.0.1/lambda.zip
$ terraform apply -var="app_version=1.0.1"
```

### Tear down environment
```
$ terraform destory
```