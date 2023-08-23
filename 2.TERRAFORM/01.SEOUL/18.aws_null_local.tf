locals {

    K8S_TPL_VALUE_INPUT = {

        KOPS_CLUSTER_USER_NAME="${var.SUB_DOMAINs[0]}"
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
            [localhost]
            localhost ansible_connection=local
            [localhost:vars]
            K8S_TPL_RENDERER_PY_FILE="${var.K8S_TPL_RENDERER_PY_FILE}
            K8S_TPL_J2_FILE="${var.K8S_TPL_J2_FILE}"
            K8S_TPL_VALUE_JSON_FILE="${var.K8S_TPL_VALUE_JSON_FILE}"
            K8S_CONF_YAML_FILE="${var.K8S_CONF_YAML_FILE}"
            EOF
        },
        {
            ALWAYS = true
            TYPE = "json"
            FILENAME = "../../${var.K8S_TPL_VALUE_JSON_FILE}"
            CONTENT = jsonencode("${local.K8S_TPL_VALUE_INPUT}")
        }
    ]
}