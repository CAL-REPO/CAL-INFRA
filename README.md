This is persnoal project to deploy infrastructure with one step and set for kubernetes cluster.
There is other repositories for OPS who manage kubernetes cluster environment and DEV who develop application.

This project purpose for infrastructure is managing kubernetes cluster on hybrid cloud environment.

Now, can deploy and manage multiple region in AWS cloud environment.
Other cloud resource is just need to be added in terraform script with provider. but maybe studying for secret data on other cloud environment will be needed.

OPS manage kubernetes manifest files on OPS repository.
DEV manage source files and docker files to create container on DEV repository.

This project is going to consider process with security.
If someone figure out any problem with security, please let me know.

But something is delayed to revise for security because of costs problem like .tfvars will be managed in S3 bucket later.