# REG0
locals {
    AWS_REG0_VPC0 = {
        NAME                = "VPC"
        CIDR                = "${var.AWS_VPC0_CIDR}"
        DNS_SUP             = true
        DNS_HOST            = true
        DHCP_NAME           = ""
        DHCP_DOMAIN         = ""
        DHCP_DOMAIN_NSs     = []
        DHCP_DOMAIN_NTPs    = []
        DHCP_DOMAIN_NBSs    = []
        DHCP_DOMAIN_NODE    = null
        Za_PUB_SN_NAMEs     = ["NAT-BASTION", "PROXY"]
        Za_PUB_SN_CIDRs     = "${var.AWS_VPC0_Za_PUB_SN_CIDRs}"
        Za_PRI_SN_NAMEs     = ["MASTER", "NODE-DB", "NODE-WP"]
        Za_PRI_SN_CIDRs     = "${var.AWS_VPC0_Za_PRI_SN_CIDRs}"
    }
    
    AWS_REG0_VPC0_RTBs = [
        {
            NAME = "${local.AWS_REG0_VPC0.Za_PUB_SN_NAMEs[0]}"
            SN_ID = "${module.AWS_REG0_VPC0.Za_PUB_SN_IDs[0]}"
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG1_CONNECTION.IGW_ID[0]
                }
            ]
        }
        ,{
            NAME = "${local.AWS_REG0_VPC0.Za_PUB_SN_NAMEs[1]}"
            SN_ID = "${module.AWS_REG0_VPC0.Za_PUB_SN_IDs[1]}"
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    gateway_id = module.AWS_REG1_CONNECTION.IGW_ID[0]
                }
            ]
        }
        ,{
            NAME = "${local.AWS_REG0_VPC0.Za_PRI_SN_NAMEs[0]}"
            SN_ID = "${module.AWS_REG0_VPC0.Za_PRI_SN_IDs[0]}"
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG0_VPC0_INS.DEFAULT_NIC_ID[0]
                }
            ]
        }
        ,{
            NAME = "${local.AWS_REG0_VPC0.Za_PRI_SN_NAMEs[1]}"
            SN_ID = "${module.AWS_REG0_VPC0.Za_PRI_SN_IDs[1]}"
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG0_VPC0_INS.DEFAULT_NIC_ID[0]
                }
            ]
        }
        ,{
            NAME = "${local.AWS_REG0_VPC0.Za_PRI_SN_NAMEs[2]}"
            SN_ID = "${module.AWS_REG0_VPC0.Za_PRI_SN_IDs[2]}"
            ROUTE = [
                {
                    cidr_block = "0.0.0.0/0"
                    network_interface_id = module.AWS_REG0_VPC0_INS.DEFAULT_NIC_ID[0]
                }
            ]
        }
        # ,{
        #     NAME = "${var.PRJ_NAME}-SEOUL-Za-FRONTEND"
        #     SN_ID = "${module.AWS_REG0_VPC0.Za_SN_IDs[4]}"
        #     ROUTE = [
        #         {
        #             cidr_block = "0.0.0.0/0"
        #             network_interface_id = module.AWS_REG0_VPC0_INS.DEFAULT_NIC_ID[0]
        #         }
        #     ]
        # }
        # ,{
        #     NAME = "${var.PRJ_NAME}-SEOUL-Za-BACKEND"
        #     SN_ID = "${module.AWS_REG0_VPC0.Za_SN_IDs[5]}"
        #     ROUTE = [
        #         {
        #             cidr_block = "0.0.0.0/0"
        #             network_interface_id = module.AWS_REG0_VPC0_INS.DEFAULT_NIC_ID[0]
        #         }
        #     ]
        # }
    ]
}