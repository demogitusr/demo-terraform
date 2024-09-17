variable "oauth_token" {
    type = string
}

provider "shell" {
    environment = {
        GO_PATH = "/Users/Admin/go"
    }
    sensitive_environment = {
        OAUTH_TOKEN = var.oauth_token
    }
    interpreter = ["/bin/sh", "-c"]
    enable_parallelism = false
}

resource "shell_script" "github_repository" {
    lifecycle_commands {
        //I suggest having these command be as separate files if they are non-trivial
        create = file("${path.module}/scripts/create.sh")
        read   = file("${path.module}/scripts/read.sh")
        update = file("${path.module}/scripts/update.sh")
        delete = file("${path.module}/scripts/delete.sh")
    }

    environment = {
        //changes to one of these will trigger an update
        NAME        = "HELLO-WORLD"
        DESCRIPTION = "description"
    }


    //sensitive environment variables are exactly the
    //same as environment variables except they don't
    //show up in log files
    sensitive_environment = {
        USERNAME = var.username
        PASSWORD = var.password
    }

    //this overrides the provider supplied interpreter
    //if you do not specify this then the default for your
    //machine will be used (/bin/sh for linux/mac and cmd for windows)
    interpreter = ["/bin/bash", "-c"]

    //sets current working directory
    working_directory = path.module

    //triggers a force new update if value changes, like null_resource
    triggers = {
        when_value_changed = var.some_value
    }
}

output "id" {
    value = shell_script.github_repository.output["id"]
}