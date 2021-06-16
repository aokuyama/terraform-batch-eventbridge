variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "batches" {
  type = map(object({
    schedule       = string
    job_queue      = string
    job_definition = string
    command        = list(string)
  }))
  default = {
    batch1 = {
      job_queue      = "job_queue_name"
      job_definition = "job_definition_name"
      schedule       = "cron(0 1 * * ? *)"
      command        = ["echo", "batch1"]
    }
    batch2 = {
      job_queue      = "job_queue_name"
      job_definition = "job_definition_name"
      schedule       = "rate(5 minutes)"
      command        = ["echo", "batch2"]
    }
  }
}
