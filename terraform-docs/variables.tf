variable "image_id" {
  default = "ami-005fc0f236362e99f" #Ubuntu Server 22.04
  #default = "ami-0c4f7023847b90238" #ubuntu 20.04.6 LTS this ami is stable for k3s

}

variable "instance_type" {
  default = "t3a.small"

}

variable "region" {
  default = "us-east-1"
}
