

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "my-dashboard"


  dashboard_body = <<EOF
{
  "widgets": [
  
    {
        "view": "timeSeries",
        "stacked": false,
        "metrics": [
            [ "AWS/EC2", "CPUUtilization", "AutoScalingGroupName", "ghost_ec2_pool" ]
        ],
        "region": "us-east-1",
        "title": "Average CPU Utilization",
        "period": 300
    },

    {
        "view": "timeSeries",
        "stacked": false,
        "metrics": [
            [ "AWS/ECS", "CPUUtilization", "ServiceName", "ghost", "ClusterName", "ghost" ]
        ],
        "region": "us-east-1",
        "title": "ECS service CPU Utilization",
        "period": 300
    },

    {
        "view": "timeSeries",
        "stacked": false,
        "metrics": [
            [ "ECS/ContainerInsights", "RunningTaskCount", "ServiceName", "ghost", "ClusterName", "ghost", { "id": "m1" } ]
        ],
        "region": "us-east-1",
        "title": "ECS Service Running Task Count",
        "period": 300,
        "stat": "Average"
    },

    {
        "metrics": [
            [ { "expression": "SELECT COUNT(ClientConnections) FROM SCHEMA(\"AWS/EFS\", FileSystemId)", "label": "Connections", "id": "q1", "region": "us-east-1", "stat": "SampleCount" } ]
        ],
        "view": "timeSeries",
        "stacked": false,
        "region": "us-east-1",
        "stat": "SampleCount",
        "period": 300,
        "title": "EFS  Client Connections"
    },


    {
        "metrics": [
            [ { "expression": "SELECT SUM(DataReadIOBytes) FROM SCHEMA(\"AWS/EFS\", FileSystemId)", "label": "EFS storage", "id": "q1", "stat": "SampleCount", "region": "us-east-1" } ]
        ],
        "view": "timeSeries",
        "stacked": false,
        "region": "us-east-1",
        "stat": "SampleCount",
        "period": 300,
        "title": "EFS Storage MBs"
    },

    {
        "view": "timeSeries",
        "stacked": false,
        "metrics": [
            [ "AWS/RDS", "DatabaseConnections" ]
        ],
        "region": "us-east-1",
        "title": "Number of database connections",
        "period": 300
    },

    {
        "view": "timeSeries",
        "stacked": false,
        "metrics": [
            [ "AWS/RDS", "WriteIOPS" ],
            [ ".", "ReadIOPS" ]
        ],
        "region": "us-east-1",
        "title": "RDS ReadIOPS, WriteIOPS",
        "period": 300
    },

    {
        "view": "timeSeries",
        "stacked": false,
        "metrics": [
            [ "AWS/RDS", "CPUUtilization" ]
        ],
        "region": "us-east-1",
        "title": "RDS CPU Utilization",
        "period": 300
    }
  ]
}
EOF
}