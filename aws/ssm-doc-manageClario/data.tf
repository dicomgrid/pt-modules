data "aws_ssm_parameter" "github_ssh" {  
  name            = "/infrastructure/github_ssh"
  with_decryption = true
}

#data.aws_ssm_parameter.github_ssh.value
