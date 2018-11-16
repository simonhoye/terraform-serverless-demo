provider "aws" {
  region = "ap-southeast-2"
}

variable "app_version" {

}

resource "aws_lambda_function" "lambda" {
  function_name = "ServerlessDemo"

  s3_bucket = "terraform-serverless-demo"
  s3_key    = "v${var.app_version}/lambda.zip"

  handler = "main.handler"
  runtime = "nodejs6.10"

  role = "${aws_iam_role.lambda_exec.arn}"
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_demo_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.lambda.execution_arn}/*/*"
}