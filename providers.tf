terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.68.0"
    }
    cedar = {
      source  = "common-fate/cedar"
      version = "0.2.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

