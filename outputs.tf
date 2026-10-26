output "instance_id" {
  description = "Created EC2 instance ID"
  value       = aws_instance.jenkins_demo.id
}

output "instance_type" {
  description = "EC2 instance type"
  value       = aws_instance.jenkins_demo.instance_type
}
