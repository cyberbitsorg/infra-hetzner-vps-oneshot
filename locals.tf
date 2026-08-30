# =============================================================================
# Local Values
# =============================================================================

locals {
  labels = {
    environment = var.environment
    managed_by  = var.managed_by
    domain      = var.domain
  }

  # Full domain: subdomain.domain.com or just domain.com
  full_domain = var.subdomain != "" ? "${var.subdomain}.${var.domain}" : var.domain
}
