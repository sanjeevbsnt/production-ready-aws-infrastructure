1. Cost Reduction Strategy
For a growing startup like Blys, every dollar spent on idle infrastructure is a dollar not spent on product innovation. I have optimized the AWS bill through three primary levers:

a. NAT Gateway Consolidation: Standard AWS best practice suggests one NAT Gateway per Availability Zone (AZ) to ensure total isolation. However, NAT Gateways carry a high fixed hourly cost (~$32/month per gateway + data processing).
So, I have setup a Single NAT Gateway architecture. Both private subnets route their outbound traffic through a single gateway in Public Subnet A.
This reduces networking costs by 50% while still allowing the application to scale across multiple AZs.

b. Serverless Compute (AWS Fargate):
Instead of managing EC2 instances,based on the requirements i have setup Fargate.

It allows for Right-Sizing.I have configured the tasks to use the minimum viable footprint (0.25 vCPU and 0.5 GB RAM).

We pay only for the seconds the container is running. There is zero cost for "idle" server capacity, and we eliminate the "hidden cost" of engineer time spent patching and managing OS/AMI updates.

2. Disaster Recovery (DR)

If one of the region goes completely offline, the following steps would restore service in a secondary region :
a.Since 100% of the infrastructure is defined in Terraform modules, we simply change the aws_region variable in our terraform.tfvars
b.DNS Failover: Update Route 53 records to point traffic to the new Application Load Balancer in the secondary region.
c. Also we can apply different DR strategies like Backup & Recovery , Pilot light , Warm standby etc to make system resilient based on the budget and uptime needs.

3. Observability Stack
To ensure logging & monitoring effectively ,I would implement a three-layered observability strategy:
Layer 1: Centralized Logging : Container logs are streamed to Amazon CloudWatch Logs with a 14-day retention policy to balance visibility and storage costs.

Layer 2: Performance Monitoring (Container Insights & Prometheus) :Using cloudwatch container isights for CPU/Memory utilization at the task and cluster level. Also we can use Prometheus and grafana for collection application specefic metrics and visualization.

Layer 3: Availability & Health (ALB & Synthetics)
ALB Target Group Health Checks: Automatically removes unhealthy containers from the rotation.
CloudWatch Alarms: I would configure alarms to trigger SNS (Slack/Email) notifications for various issues.
