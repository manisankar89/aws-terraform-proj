variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_configs" {
  description = "Map of instance attributes"
  type = map(object({
    ami           = string
    instance_type = string
    sg_ports      = list(number)
  }))
  default = {
    windows = {
      # Replace with the latest Windows Server 2022 AMI for your region
      ami           = "ami-06b2de7a5ae9b1ba3"
      instance_type = "t3.small"
      sg_ports      = [3389]
    }
    rhel = {
      # Replace with latest RHEL 8.2 AMI for your region
      ami           = "ami-07378eee6a8e82f97"
      instance_type = "t3.micro"
      sg_ports      = [22]
    }
    amazonlinux = {
      # Replace with latest Amazon Linux 2 AMI for your region
      ami           = "ami-0a1235697f4afa8a4"
      instance_type = "t3.small"
      sg_ports      = [22]
    }
  }
}
