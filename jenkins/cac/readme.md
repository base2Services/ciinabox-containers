This version of the container allows a lot loaded overlay from any webserver or S3 bucket.

## HTTP
To download from HTTP simply set the environment variable:

    SRCTAR

To the URL of an (uncompressed) tar file, it will be extracted over /

## S3
To download from HTTP simply set the environment variable:

    SRCTAR

To the S3 URL of an (uncompressed) tar file, it will be extracted over /. The URL should look like this:
s3://<bucket>/<path>

It will remove all parameters.

You will also need to specify a EC2 Instance Role in the variable:

    IAM_ROLE
    
It will then grab the the security credentials from: 

    http://169.254.169.254/latest/meta-data/iam/security-credentials/ 

You should ensure that the role is setup with S3 read access.