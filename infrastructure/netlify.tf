variable "branch" {
  default = "master"
}

# Configure the Netlify Provider
provider "netlify" {}

# Create a new deploy key for this specific website
resource "netlify_deploy_key" "key" {}

# Define your site
resource "netlify_site" "main" {
  name = "demo-react-static-contentful"

  repo {
    repo_branch   = "${var.branch}"
    command       = "npm install && npm run build"
    deploy_key_id = "${netlify_deploy_key.key.id}"
    dir           = "dist"
    provider      = "github"
    repo_path     = "${var.org}/${var.repo}"
  }
}
