variable "availability_zone" {
  type = string
}

variable "size_gb" {
  type = number
}

variable "tags" {
  type    = map(string)
  default = {}
}
