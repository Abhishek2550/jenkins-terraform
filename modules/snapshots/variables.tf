variable "target_tag" {
  type    = string
  default = "Backup"
}

variable "target_value" {
  type    = string
  default = "true"
}

variable "retain_count" {
  type    = number
  default = 7
}
