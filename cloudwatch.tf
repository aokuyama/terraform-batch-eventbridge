resource "aws_cloudwatch_event_rule" "batch-rule" {
  for_each            = var.batches
  name                = each.key
  event_pattern       = null
  schedule_expression = each.value.schedule
  lifecycle {
    ignore_changes = [
      is_enabled
    ]
  }
  description = each.value.description
}

resource "aws_cloudwatch_event_target" "batch-target" {
  for_each = var.batches
  rule     = aws_cloudwatch_event_rule.batch-rule[each.key].name
  arn      = "arn:aws:batch:${var.region}:${data.aws_caller_identity.self.account_id}:job-queue/${each.value.job_queue}"
  batch_target {
    job_definition = "arn:aws:batch:${var.region}:${data.aws_caller_identity.self.account_id}:job-definition/${each.value.job_definition}"
    job_name       = each.key
  }
  role_arn = aws_iam_role.event_target.arn
  input = jsonencode(
    {
      ContainerOverrides = {
        Command = each.value.command
      }
    }
  )
}
