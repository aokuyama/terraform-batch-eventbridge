variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "batches" {
  type = map(object({
    schedule           = string
    job_queue_arn      = string
    job_definition_arn = string
    command            = list(string)
  }))
  default = {
    batch1 = {
      job_queue_arn      = "arn:aws:batch:ap-northeast-1:xxxxxxxxxxxx:job-queue/xxxx"
      job_definition_arn = "arn:aws:batch:ap-northeast-1:xxxxxxxxxxxx:job-definition/xxxxx"
      schedule           = "cron(0 1 * * ? *)"
      command            = ["echo", "batch1"]
    }
    batch2 = {
      job_queue_arn      = "arn:aws:batch:ap-northeast-1:xxxxxxxxxxxx:job-queue/xxxx"
      job_definition_arn = "arn:aws:batch:ap-northeast-1:xxxxxxxxxxxx:job-definition/xxxxx"
      schedule           = "rate(5 minutes)"
      command            = ["echo", "batch2"]
    }
  }
}
