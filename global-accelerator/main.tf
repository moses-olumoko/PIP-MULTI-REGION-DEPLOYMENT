###############################################
# Global Accelerator
resource "aws_globalaccelerator_accelerator" "example" {
  name               = "olumoko-accelerator"
  enabled            = true
  ip_address_type    = "IPV4"
}

# Listener
resource "aws_globalaccelerator_listener" "example_listener" {
  accelerator_arn = aws_globalaccelerator_accelerator.example.id
  protocol        = "TCP"
  port_range {
    from_port = 80
    to_port   = 80
  }
}

# Endpoint Group for both Vote and Result services in eu-west-1
resource "aws_globalaccelerator_endpoint_group" "eu_west_1_endpoint_group" {
  listener_arn          = aws_globalaccelerator_listener.example_listener.id
  endpoint_group_region = "eu-west-1"
  health_check_path     = "/vote" # Primary health check path, can be either /vote or /result based on your needs
  health_check_port     = 80
  health_check_protocol = "HTTP"

  # Vote Service Endpoint in eu-west-1
  endpoint_configuration {
    endpoint_id = var.primary_service_endpoint # Vote ALB ARN in eu-west-1
    weight      = 128
  }

  # Result Service Endpoint in eu-west-1
  endpoint_configuration {
    endpoint_id = var.primary_service_endpoint # Result ALB ARN in eu-west-1
    weight      = 128
  }
}

# Endpoint Group for both Vote and Result services in us-west-2
resource "aws_globalaccelerator_endpoint_group" "us_west_2_endpoint_group" {
  listener_arn          = aws_globalaccelerator_listener.example_listener.id
  endpoint_group_region = "us-west-2"
  health_check_path     = "/vote" # Primary health check path, can be either /vote or /result based on your needs
  health_check_port     = 80
  health_check_protocol = "HTTP"

  # Vote Service Endpoint in us-west-2
  endpoint_configuration {
    endpoint_id = var.secondary_service_endpoint # Vote ALB ARN in us-west-2
    weight      = 128
  }

  # Result Service Endpoint in us-west-2
  endpoint_configuration {
    endpoint_id = var.secondary_service_endpoint # Result ALB ARN in us-west-2
    weight      = 128
  }
}
