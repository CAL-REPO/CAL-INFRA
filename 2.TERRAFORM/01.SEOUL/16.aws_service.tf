# GLOBAL
locals {
    AWS_KOPS_RT53_ZONEs = [
        {  
            NAME = "${var.SUB_DOMAINs[0]}"
            TYPE_PRIVATE = false           
            DOMAIN_NAME = "${var.SUB_DOMAINs[0]}.${var.CF_DOMAIN_MAIN}"
        }
    ]

    # AWS_ALBs = [
    #     {  
    #         NAME = "devkops-cluster-ingress-controller"
    #         TYPE = false           
    #         INTERNAL = false
    #         SNs = 
    #         DELETE_PROTECTION = false
    #         SNs_MAP = optional(list(object({
    #             SN_ID     = optional(string)
    #             EIP_ID    = optional(string)
    #         })))
    #     }
    # ]
}