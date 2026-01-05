terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

variable "github_token" { type = string }
variable "repo_name" { type = string }

provider "github" {
  token = var.github_token
}

# 1. Create the Repo
resource "github_repository" "web_repo" {
  name        = var.repo_name
  description = "Simple HTML/CSS/JS site pushed via Terraform"
  visibility  = "public"
  auto_init   = false
}

# 2. Push the Code (Updated for Windows & Auth)
resource "null_resource" "push_code" {
  depends_on = [github_repository.web_repo]

  provisioner "local-exec" {
    # CRITICAL FOR WINDOWS: Use PowerShell to run these commands
    interpreter = ["PowerShell", "-Command"]
    
    command = <<EOT
      # Initialize and Commit
      git init
      git add .
      git commit -m "First commit - Automated by Terraform"
      git branch -M main
      
      # CRITICAL FIX: Add the remote with the TOKEN embedded in the URL
      # This bypasses the password prompt
      git remote add origin https://${var.github_token}@github.com/${github_repository.web_repo.full_name}.git
      
      # Push
      git push -u origin main
    EOT
  }
}