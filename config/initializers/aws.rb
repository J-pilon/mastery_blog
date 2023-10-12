aws_credentials = Rails.application.credentials.aws

Aws.config.update(
  region: 'us-east-1',
  credentials: Aws::Credentials.new(aws_credentials.access_key_id, aws_credentials.secret_access_key)
)
