resource "aws_iam_role" "event_target" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "events.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  managed_policy_arns = [
    aws_iam_policy.event_target.arn,
  ]
  path = "/service-role/"
}

resource "aws_iam_policy" "event_target" {
  path = "/service-role/"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "batch:SubmitJob",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
      Version = "2012-10-17"
    }
  )
}
