variable "PRJ_NAME"{
    type = string
    default = ""
}    

variable "PRJ_VERSION"{
    type = string
    default = ""
}

variable "AWS_PROFILE_NAME"{
    type = string
    default = ""
}

variable "AWS_KEY_S3_BUCKET_NAME"{
    type = string
    default = ""
    description = "Main domain name is managed by cloudflare"
}

variable "AWS_KEY_S3_BUCKET_DIR"{
    type = string
    default = ""
}

variable "AWS_KOPS_STATE_S3_BUCKET"{
    type = string
    default = ""
    description = "Main domain name is managed by cloudflare"
}

variable "AWS_KOPS_STATE_S3_BUCKET_DIR" {
    type = string
    default = ""
}

variable "AWS_VPC_CIDRs" {
    type = list(string)
    default = []
}

variable "AWS_VPC0_Za_PUB_SN_CIDRs" {
    type = list(string)
    default = []
}

variable "AWS_VPC0_Za_PRI_SN_CIDRs" {
    type = list(string)
    default = []
}

variable "AWS_VPC0_Za_INS_IPV4s" {
    type = list(string)
    default = []
}

variable "AWS_VPC0_Zb_PUB_SN_CIDRs" {
    type = list(string)
    default = []
}

variable "AWS_VPC0_Zb_PRI_SN_CIDRs" {
    type = list(string)
    default = []
}

variable "AWS_VPC0_Zb_INS_IPV4s" {
    type = list(string)
    default = []
}

variable "AWS_VPC0_Zc_PUB_SN_CIDRs" {
    type = list(string)
    default = []
}

variable "AWS_VPC0_Zc_PRI_SN_CIDRs" {
    type = list(string)
    default = []
}
variable "AWS_VPC0_Zc_INS_IPV4s" {
    type = list(string)
    default = []
}

variable "AWS_INS_AMIs" {
    type = list(string)
    default = []
}

variable "AWS_INS_TYPEs" {
    type = list(string)
    default = []
}

variable "AWS_INS_VOL_DIRs" {
    type = list(string)
    default = []
}

variable "AWS_INS_VOL_SIZEs" {
    type = list(number)
    default = []
}

variable "AWS_INS_VOL_TYPEs" {
    type = list(string)
    default = []
}

variable "AWS_INS_UDs_FILEs" {
    type = list(list(string))
    default = []
}

variable "CF_DOMAIN_MAIN" {
    description = "Main domain name is managed by cloudflare"
}

variable "SUB_DOMAINs" {
    type = list(string)
    default = []    
}

variable "OPS_USER_NAME" {
    description = "Bastion host user name"
}

variable "OPS_USER_PW" {
    description = "Bastion host password"
}

variable "OPS_GIT_USER_NAME" {
    description = "Bastion host git user name"
}

variable "OPS_GIT_USER_EMAIL" {
    description = "Bastion host git user email"
}

variable "OPS_GIT_REPO_URL" {
    description = "Git repository url for OPS"
}

variable "OPS_GIT_REPO_AUTH_URL" {
    description = "Git repository auth url for OPS"
}

variable "ANSIBLE_CONF_FILE" {
    description = "Ansible configuration file path"
}

variable "ANSIBLE_HOSTS_FILE" {
    description = "Ansible hosts file path"
}

varialbe "K8S_TPL_VALUE_NEW_JSON_FILE" {
    description = "Kubernetes cluster template j2 file path which is created by terraform"
}

varialbe "K8S_TPL_RENDERER_PY_FILE" {
    description = "Python script path to render from kubenetes cluster template j2 file to kubernetes cluster configuration yaml file"
}

varialbe "K8S_TPL_J2_FILE" {
    description = "Kubernetes cluster template j2 file path to set as ansible variant"
}

varialbe "K8S_TPL_VALUE_JSON_FILE" {
    description = "Kubernetes cluster template value json file path to set as ansible variant"
}

varialbe "K8S_TPL_CONF_YAML_FILE" {
    description = "Kubernetes cluster configuration file path to set as ansible variant"
}