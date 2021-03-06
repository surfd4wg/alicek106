locals {
  common_tags = {
    "kubernetes.io/cluster/${var.cluster_id_tag}" = "${var.cluster_id_value}"
  }
}

#############################
# Adjustable variables
#############################

variable "number_of_controller" {
  description = "The number of controller, only acts as controller"
  default     = 2
}

variable "number_of_etcd" {
  description = "The number of etcd, only acts as etcd"
  default     = 2
}

variable "number_of_controller_etcd" {
  description = "The number of nodes which act as controller and etcd simultaneously"
  default     = 1
}

variable "number_of_worker" {
  description = "The number of worker nodes"
  default     = 3
}

variable "cluster_id_tag" {
  description = "Cluster ID tag for kubespray"
  default     = "alice"
}

variable "cluster_id_value" {
  description = "Cluster ID value, it can be shared or owned"
  default     = "owned"
}

##########################
# Default variables (you can change for customizing)
##########################

variable "control_cidr" {
  description = "CIDR for maintenance: inbound traffic will be allowed from this IPs"
  default     = "0.0.0.0/0"
}

locals {
  default_keypair_public_key = file("../keys/tf-kube.pub")
}

/*
## It triggers interpolation. It is recommended to use another way.
## TODO : Replace default_keypair_public_key as output?
variable default_keypair_public_key {
  description = "Public Key of the default keypair"
  default = "${file("../keys/tf-kube.pub")}"
}
*/

variable "default_keypair_name" {
  description = "Name of the KeyPair used for all nodes"
  default     = "tf-kube"
}


variable "vpc_name" {
  description = "Name of the VPC"
  default     = "kubernetes"
}

variable "elb_name" {
  description = "Name of the ELB for Kubernetes API"
  default     = "kubernetes"
}

variable "owner" {
  default = "alicek106"
}

variable "ansibleFilter" {
  description = "`ansibleFilter` tag value added to all instances, to enable instance filtering in Ansible dynamic inventory"
  default     = "Kubernetes01" # IF YOU CHANGE THIS YOU HAVE TO CHANGE instance_filters = tag:ansibleFilter=Kubernetes01 in ./ansible/hosts/ec2.ini
}

# Networking setup
variable "region" {
  default = "ap-northeast-2"
}

variable "zone" {
  default = "ap-northeast-2a"
}

### VARIABLES BELOW MUST NOT BE CHANGED ###

variable "vpc_cidr" {
  default = "10.43.0.0/16"
}

variable "kubernetes_pod_cidr" {
  default = "10.200.0.0/16"
}


# Instances Setup
variable "amis" {
  description = "Default AMIs to use for nodes depending on the region"
  type        = map(string)
  default = {
    # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
    ap-northeast-2 = "ami-0454bb2fefc7de534"
    ap-northeast-1 = "ami-088da9557aae42f39"
    ap-southeast-1 = "ami-055d15d9cfddf7bd3"
    eu-central-1   = "ami-0d527b8c289b4af7f"
    eu-west-1      = "ami-08ca3fed11864d6bb"
    sa-east-1      = "ami-090006f29ecb2d79a"
    us-east-1      = "ami-04505e74c0741db8d"
    us-west-1      = "ami-01f87c43e618bf8f0"
    us-west-2      = "ami-0892d3c7ee96c0bf7"
  }
}
variable "default_instance_user" {
  default = "ubuntu"
}

variable "etcd_instance_type" {
  default = "t2.small"
}
variable "controller_instance_type" {
  default = "t2.small"
}
variable "worker_instance_type" {
  default = "t2.small"
}


variable "kubernetes_cluster_dns" {
  default = "10.31.0.1"
}
