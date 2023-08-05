data "aws_route53_zone" "selected" {
  count        = var.hosted_zone_id == "" && var.hostname_create ? 1 : 0
  name         = var.hosted_zone
  private_zone = var.hosted_zone_is_internal
}

resource "aws_route53_record" "hostnames" {
  count   = !var.hosted_zone_is_internal && var.hostname_create && length(var.hostnames) != 0 ? length(var.hostnames) : 0
  zone_id = var.hosted_zone_id == "" ? data.aws_route53_zone.selected.*.zone_id[0] : var.hosted_zone_id
  name    = var.hostnames[count.index]
  type    = "A"
  ttl     = "300"
  records = [aws_eip.this.public_ip]
}