# Remote State of Core module
data "terraform_remote_state" "core_rs" {
    backend = "s3"
    config {
        bucket = "${var.core_rs_bucket}"
        key    = "${var.core_rs_key}"
        region = "${var.region}"
    }
}
