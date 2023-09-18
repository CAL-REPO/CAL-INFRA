# REG0
locals {
    AWS_REG0_IGW = [
        {
            NAME = "${var.PRJ_NAME}-IGW"
            VPC_ID = "${module.AWS_REG0_VPC1.VPC_ID}"
        }
    ]
}