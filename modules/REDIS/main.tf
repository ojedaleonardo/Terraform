resource "aws_elasticache_replication_group" "Redis" {
  depends_on                 = [var.redis_security_group_id]
  replication_group_id       = "Redis"
  node_type                  = "cache.t2.micro"
  security_group_ids         = [var.redis_security_group_id]
  automatic_failover_enabled = true
  multi_az_enabled           = true
  transit_encryption_enabled = true
  at_rest_encryption_enabled = true
  auth_token                 = "Cl0udH3s1v32024$"
  subnet_group_name          = var.redis_subnet_group_id
  description                = "Cluster de Redis"
  port                       = 6379
  parameter_group_name       = "default.redis7.cluster.on"
  num_node_groups            = 2
  replicas_per_node_group    = 1
}



