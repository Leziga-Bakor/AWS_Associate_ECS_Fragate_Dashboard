resource "aws_ecs_cluster" "ghost_cluster" {
  name = "ghost"

  setting {
    name = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.ghost_cluster.name

  capacity_providers = ["FARGATE"]

}

resource "aws_ecs_task_definition" "task_def_ghost" {
  family = "task_def_ghost"
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.ghost_ecs.arn
  task_role_arn = aws_iam_role.ghost_ecs.arn
  requires_compatibilities = ["FARGATE"]

  container_definitions = <<EOF
[
  {
    "name": "task_def_ghost",
    "image": "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/${var.ecr_name}:5.33",
    "cpu": 0,
    "portMappings": [
      {
        "name": "ghost_container-2368-tcp",
        "containerPort": 2368,
        "hostPort": 2368,
        "protocol": "tcp"
      }
    ],
    "essential": true,
    "environment": [
      {
        "name": "database__connection__database",
        "value": "ghost"
      },
      {
        "name": "database__connection__host",
        "value": "${replace(aws_db_instance.ghost.endpoint, "/:[0-9]+/", "")}"
      },
      {
        "name": "database__connection__password",
        "value": "${aws_ssm_parameter.foo.value}"
      },
      {
        "name": "database__client",
        "value": "mysql"
      },
      {
        "name": "database__connection__user",
        "value": "foo"
      }
    ],
    "mountPoints": [
      {
        "sourceVolume": "ghost_content",
        "containerPath": "/var/lib/ghost/content"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "ghost-container",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "ghost"
      }
    }
  }
]
EOF

  cpu = 256
  memory = 1024

  volume {
    name = "ghost_content"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.ghost_content.id
    }
  }
}

# variable "account_id" {
#   type = string
# }

# variable "ecr_name" {
#   type = string
# }

# variable "db_password" {
#   type = string
# }



resource "aws_ecs_service" "ghost_service" {
  name            = "ghost"
  cluster         = aws_ecs_cluster.ghost_cluster.id
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.fragate_pool.id]
    subnets          = [
      aws_subnet.ecs_private_a.id,
      aws_subnet.ecs_private_b.id,
      aws_subnet.ecs_private_c.id,
    ]
  }

  task_definition = aws_ecs_task_definition.task_def_ghost.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.ghost-fragate.arn
    container_port   = 2368
    container_name   = "task_def_ghost"
  }

  health_check_grace_period_seconds = 30
}