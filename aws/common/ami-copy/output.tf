output "copied_ami_id" {
  description = "The ID of the copied AMI in the target region."
  value       = aws_ami_copy.ami_copy.id
}