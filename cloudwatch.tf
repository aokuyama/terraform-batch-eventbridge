resource "aws_cloudwatch_event_rule" "batch-rule" {
  for_each            = var.batches
  name                = each.key
  event_pattern       = null
  schedule_expression = each.value.schedule
}

resource "aws_cloudwatch_event_target" "batch-target" {
  for_each = var.batches
  rule     = aws_cloudwatch_event_rule.batch-rule[each.key].name
  arn      = each.value.job_queue_arn
  batch_target {
    job_definition = each.value.job_definition_arn
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
