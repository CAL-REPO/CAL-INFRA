locals {

    KOPS_TPL_VALUE_INPUT = {

        KOPS_STATE_S3_BUCKET="${var.AWS_KOPS_STATE_S3_BUCKET}"
        KOPS_STATE_S3_DIR="${var.AWS_KOPS_STATE_S3_BUCKET_DIR}"
        KOPS_STATE_S3="s3://${var.AWS_KOPS_STATE_S3_BUCKET}/${var.AWS_KOPS_STATE_S3_BUCKET_DIR}"
        KOPS_CLUSTER_NAME="${var.SUB_DOMAINs[0]}.${var.CF_DOMAIN_MAIN}"
        KOPS_CLUSTER_VERSION="v1.27.3"
        KOPS_CLUSTER_CONTAINER_RUNTIME="containerd"
        KOPS_CLUSTER_CLOUD="aws"
        KOPS_CLUSTER_API_PUBLIC_NAME="${var.SUB_DOMAINs[0]}.${var.CF_DOMAIN_MAIN}"
        KOPS_CLUSTER_MASTER_TOPOLOGY="private"
        KOPS_CLUSTER_NODE_TOPOLOGY="private"
        KOPS_CLUSTER_NETWORK_ID="${module.AWS_REG1_VPC1.VPC_ID}"
        KOPS_CLUSTER_NETWORK_CIDR=""
        KOPS_CLUSTER_LB_TYPE="Internal"
        KOPS_CLUSTER_LB_CLASS="Network"
        KOPS_CLUSTER_BASTION_CIDR="${var.AWS_VPC0_Za_PUB_SN_CIDRs[0]}"
        KOPS_CLUSTER_SSH_PUBLIC_KEY ="${module.AWS_REG1_KEY.PUB_KEY[0]}"
        KOPS_CLUSTER_SUBNETS=[
            {
                cidr="${var.AWS_VPC0_Za_PUB_SN_CIDRs[1]}"
                id="${module.AWS_REG1_VPC1.Za_SNs_ID[1]}"
                name="${local.AWS_REG1_VPC1.Za_SNs_NAME[1]}"
                type="Utility"
                zone="ap-northeast-2a"
            },
            {
                cidr="${var.AWS_VPC0_Za_PRI_SN_CIDRs[0]}"
                id="${module.AWS_REG1_VPC1.Za_SNs_ID[2]}"
                name="MASTER-${local.AWS_REG1_VPC1.Za_SNs_NAME[2]}"
                type="Private"
                zone="ap-northeast-2a"
            },
            {
                cidr="${var.AWS_VPC0_Za_PRI_SN_CIDRs[1]}"
                id="${module.AWS_REG1_VPC1.Za_SNs_ID[3]}"
                name="NODE-${local.AWS_REG1_VPC1.Za_SNs_NAME[3]}"
                type="Private"
                zone="ap-northeast-2a"
            },
            {
                cidr="${var.AWS_VPC0_Za_PRI_SN_CIDRs[2]}"
                id="${module.AWS_REG1_VPC1.Za_SNs_ID[4]}"
                name="NODE-${local.AWS_REG1_VPC1.Za_SNs_NAME[4]}"
                type="Private"
                zone="ap-northeast-2a"
            }
        ]
        KOPS_CLUSTER_ETCD = [

            {
                instanceGroup = "MASTER-${local.AWS_REG1_VPC1.Za_SNs_NAME[2]}"
                name = "a"
            }
        ]
        KOPS_CLUSTER_IGS = [
            {
                name="MASTER-${local.AWS_REG1_VPC1.Za_SNs_NAME[2]}"
                image="099720109477/ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230711"
                machineType="t3.medium"
                maxSize="1"
                minSize="1"
                role="Master"
                subnets=["MASTER-${local.AWS_REG1_VPC1.Za_SNs_NAME[2]}"]
            },
            {
                name="NODE-${local.AWS_REG1_VPC1.Za_SNs_NAME[3]}"
                image="099720109477/ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230711"
                machineType="t2.micro"
                maxSize="1"
                minSize="1"
                role="Node"
                subnets=["NODE-${local.AWS_REG1_VPC1.Za_SNs_NAME[3]}"]
            },
            {
                name="NODE-${local.AWS_REG1_VPC1.Za_SNs_NAME[4]}"
                image="099720109477/ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230711"
                machineType="t2.micro"
                maxSize="1"
                minSize="1"
                role="Node"
                subnets=["NODE-${local.AWS_REG1_VPC1.Za_SNs_NAME[4]}"]
            }
        ]
    }

    LOCAL_CREATE_FILEs = [
        {
            ALWAYS = true
            TYPE = "utf-8"
            FILENAME = "../../${var.ANSIBLE_CONF_FILE}"
            CONTENT = <<-EOF
            [defaults]
            EOF
        },
        {
            ALWAYS = true
            TYPE = "utf-8"
            FILENAME = "../../${var.ANSIBLE_HOSTS_FILE}"
            CONTENT = <<-EOF
            [local]
            localhost ansible_connection=local ansible_user=runner
            [local:vars]
            
            [bastion]
            ${module.AWS_REG1_ADD.EIP_IP[0]} ansible_user="${var.OPS_USER_NAME}" ansible_ssh_private_key_file="${module.AWS_REG1_KEY.KEY_PRI_RUNNER_FILE[0]}"
            [bastion:vars]
            MAIN_DOMAIN="${var.CF_DOMAIN_MAIN}"
            AWS_PAGER=""
            AWS_PROFILE="${local.AWS_PROFILEs[0].NAME}"
            AWS_RT53_ZONE_ID = "${module.AWS_GLOBAL_SERVICE.RT53_ZONE_ID[0]}
            GIT_USER_NAME="${var.OPS_GIT_USER_NAME}"
            GIT_USER_EMAIL="${var.OPS_GIT_USER_EMAIL}"
            GIT_LOCAL_DIR="/home/${var.OPS_USER_NAME}/infra"
            GIT_LOCAL_REMOTE_NAME="CAL-OPS"
            GIT_REPO_URL="${var.OPS_GIT_REPO_URL}"
            GIT_REPO_AUTH_URL="${var.OPS_GIT_REPO_AUTH_URL}"
            GIT_COMMIT_MESSAGE="Commited by infra manager"
            GIT_BRANCH_NAME="initial"
            ANSIBLE_DIR="/home/${var.OPS_USER_NAME}/infra/ansible"
            ANSIBLE_CONF_FILE="{{ playbook_dir }}/../../${var.ANSIBLE_CONF_FILE}"
            ANSIBLE_CONF_FILE_NAME="${basename(var.ANSIBLE_CONF_FILE)}"
            ANSIBLE_HOSTS_FILE="{{ playbook_dir }}/../../${var.ANSIBLE_HOSTS_FILE}"
            ANSIBLE_HOSTS_FILE_NAME="${basename(var.ANSIBLE_HOSTS_FILE)}"
            KOPS_TPL_RENDERER_PY_FILE="{{ playbook_dir }}/../../${var.KOPS_TPL_RENDERER_PY_FILE}"
            KOPS_TPL_RENDERER_PY_FILE_NAME="${basename(var.KOPS_TPL_RENDERER_PY_FILE)}"
            KOPS_TPL_J2_FILE="{{ playbook_dir }}/../../${var.KOPS_TPL_J2_FILE}"
            KOPS_TPL_J2_FILE_NAME="${basename(var.KOPS_TPL_J2_FILE)}"
            KOPS_TPL_VALUE_JSON_FILE="{{ playbook_dir }}/../../${var.KOPS_TPL_VALUE_JSON_FILE}"
            KOPS_TPL_VALUE_JSON_FILE_NAME="${basename(var.KOPS_TPL_VALUE_JSON_FILE)}"
            KOPS_CONF_YAML_FILE="{{ playbook_dir }}/../../${var.KOPS_CONF_YAML_FILE}"
            KOPS_CONF_YAML_FILE_NAME="${basename(var.KOPS_CONF_YAML_FILE)}"
            KOPS_MANIFEST_YAML_DIR="{{ playbook_dir }}../../${var.KOPS_MANIFEST_YAML_DIR}"
            KOPS_DIR="/home/${var.OPS_USER_NAME}/infra/kops"
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