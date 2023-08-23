locals {

    KOPS_TPL_VALUE_INPUT = {

        KOPS_STATE_S3_BUCKET="${var.AWS_KOPS_STATE_S3_BUCKET}"
        KOPS_STATE_S3_DIR="${var.AWS_KOPS_STATE_S3_BUCKET_DIR}"
        KOPS_STATE_S3="s3://${var.AWS_KOPS_STATE_S3_BUCKET}/${var.AWS_KOPS_STATE_S3_BUCKET_DIR}"
        KOPS_CLUSTER_USER_NAME="${var.SUB_DOMAINs[0]}"
        KOPS_CLUSTER_NAME="${var.SUB_DOMAINs[0]}.${var.CF_DOMAIN_MAIN}"
        KOPS_CLUSTER_VERSION="v1.27.3"
        KOPS_CLUSTER_CONTAINER_RUNTIME="containerd"
        KOPS_CLUSTER_CLOUD="aws"
        KOPS_CLUSTER_API_PUBLIC_NAME="${var.SUB_DOMAINs[0]}.${var.CF_DOMAIN_MAIN}"
        KOPS_CLUSTER_TOPOLOGY="private"
        KOPS_CLUSTER_NETWORK="calico"
        KOPS_CLUSTER_NETWORK_ID="${module.AWS_REG1_VPC1.VPC_ID}"
        KOPS_CLUSTER_LB_TYPE="internal"
        KOPS_CLUSTER_LB_CLASS="network"
        KOPS_CLUSTER_ZONES="${local.AWS_REGIONs[0].CODE}a"
        KOPS_CLUSTER_MASTER_ZONES="${local.AWS_REGIONs[0].CODE}a"
        KOPS_CLUSTER_MASTER_SIZE="t3.medium"
        KOPS_CLUSTER_NODE_SIZE="t2.micro"
        KOPS_CLUSTER_NODE_COUNT=1
        KOPS_CLUSTER_UTILITY_SUBNETS="${module.AWS_REG1_VPC1.Za_SNs_ID[1]}"
        KOPS_CLUSTER_SUBNETS="${module.AWS_REG1_VPC1.Za_SNs_ID[2]},${module.AWS_REG1_VPC1.Za_SNs_ID[3]}"
        KOPS_CLUSTER_BASTION_CIDR="${var.AWS_VPC0_Za_PUB_SN_CIDRs[0]}"
        KOPS_CLUSTER_SSH_PUBLIC_KEY_FILE="/home/${var.OPS_USER_NAME}/.ssh/authorized_keys"
        ####
        # IG = [
        #     {
        #         image
        #         machineType
        #         maxSize
        #         minSize
        #     }
        # ]
    }

    LOCAL_CREATE_FILEs = [
        {
            ALWAYS = true
            TYPE = "utf-8"
            FILENAME = "${var.ANSIBLE_CONF_FILE}"
            CONTENT = <<-EOF
            [defaults]
            EOF
        },
        {
            ALWAYS = true
            TYPE = "utf-8"
            FILENAME = "${var.ANSIBLE_HOSTS_FILE}"
            CONTENT = <<-EOF
            [localhost:vars]
            KOPS_TPL_RENDERER_PY_FILE="${var.KOPS_TPL_RENDERER_PY_FILE}
            KOPS_TPL_J2_FILE="${var.KOPS_TPL_J2_FILE}"
            KOPS_TPL_VALUE_JSON_FILE="${var.KOPS_TPL_VALUE_JSON_FILE}"
            KOPS_CONF_YAML_FILE="${var.KOPS_CONF_YAML_FILE}"
            [bastion]
            ${module.AWS_REG1_ADD.EIP_IP[0]} ansible_user="${var.OPS_USER_NAME}" ansible_ssh_private_key_file="${module.AWS_REG1_KEY.KEY_PRI_RUNNER_FILE[0]}"
            [bastion:vars]
            MAIN_DOMAIN="${var.CF_DOMAIN_MAIN}"
            AWS_PAGER=""
            AWS_PROFILE="${local.AWS_PROFILEs[0].NAME}"
            GIT_USER_NAME="${var.OPS_GIT_USER_NAME}"
            GIT_USER_EMAIL="${var.OPS_GIT_USER_EMAIL}"
            GIT_LOCAL_DIR="/home/${var.OPS_USER_NAME}/infra"
            GIT_LOCAL_REMOTE_NAME="CAL-OPS"
            GIT_REPO_URL="${var.OPS_GIT_REPO_URL}"
            GIT_REPO_AUTH_URL="${var.OPS_GIT_REPO_AUTH_URL}"
            GIT_COMMIT_MESSAGE="Commited by infra manager"
            GIT_BRANCH_NAME="initial"
            KOPS_DIR="/home/${var.OPS_USER_NAME}/infra/kops"
            KOPS_ORIGIN_CONF_YAML_FILE="${var.KOPS_CONF_YAML_FILE}"
            KOPS_CONF_YAML_FILE="/home/${var.OPS_USER_NAME}/infra/kops/${basename(var.KOPS_CONF_YAML_FILE)}"
            KOPS_CLUSTER_NAME="${var.SUB_DOMAINs[0]}.${var.CF_DOMAIN_MAIN}"
            KOPS_STATE_S3_BUCKET="${var.AWS_KOPS_STATE_S3_BUCKET}"
            KOPS_STATE_S3_DIR="${var.AWS_KOPS_STATE_S3_BUCKET_DIR}"
            KOPS_STATE_S3="s3://${var.AWS_KOPS_STATE_S3_BUCKET}/${var.AWS_KOPS_STATE_S3_BUCKET_DIR}"
            EOF
        },
        {
            ALWAYS = true
            TYPE = "json"
            FILENAME = "../../${var.KOPS_TPL_VALUE_JSON_FILE}"
            CONTENT = jsonencode("${local.KOPS_TPL_VALUE_INPUT}")
        }
    ]
}