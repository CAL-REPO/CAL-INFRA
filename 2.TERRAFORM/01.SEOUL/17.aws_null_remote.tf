locals {

    RUNNER_HOST = {
        USER = "runner"
        USER_DIR = "${local.AWS_REG1_KEYs[0].RUNNER_DIR}"
        PRI_KEY_FILE = "${module.AWS_REG1_KEY.KEY_PRI_RUNNER_FILE[0]}"
    }

    REMOTE_HOST_OPS = {
        USER = "${var.OPS_USER_NAME}"
        USER_DIR = "/home/${var.OPS_USER_NAME}"
        EXTERNAL_IP = "${module.AWS_REG1_ADD.EIP_IP[0]}"
    }

    REMOTE_PRE_EXECUTEs_FOR_OPS= [
        {
            ALWAYS = false
            COMMANDs = [
                "if [ -f ${local.REMOTE_HOST_OPS.USER_DIR}/.ssh/${local.REMOTE_HOST_OPS.KOPS_PRI_KEY_FILE_NAME} ]; then",
                "  sudo rm -rf ${local.REMOTE_HOST_OPS.USER_DIR}/.ssh/${local.REMOTE_HOST_OPS.KOPS_PRI_KEY_FILE_NAME}",
                "fi"
            ]
        }
    ]

    REMOTE_SEND_FILEs_FOR_OPS= [
        {
            ALWAYS = false
            SOURCE = "${local.RUNNER_HOST.PRI_KEY_FILE}"
            DESTINATION = "${local.REMOTE_HOST_OPS.USER_DIR}/.ssh/${local.REMOTE_HOST_OPS.KOPS_PRI_KEY_FILE_NAME}"
            COMMANDs = ["sudo chmod 400 ${local.REMOTE_HOST_OPS.USER_DIR}/.ssh/${local.REMOTE_HOST_OPS.KOPS_PRI_KEY_FILE_NAME}"]
        }
    ]

}