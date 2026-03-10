# =============================================================================
# Login Credentials
# =============================================================================

output "server_ip" {
  description = "Server IPv4 address"
  value       = hcloud_server.vps.ipv4_address
}

output "login_credentials" {
  description = "Initial admin password (change after first login)"
  value       = <<-EOT
    Password: ${random_password.admin_password.result}
  EOT
  sensitive   = true
}

# =============================================================================
# Next Steps
# =============================================================================

output "next_steps" {
  description = "Steps to complete setup"
  value       = <<-EOT

    === NEXT STEPS ===

    1. Configure DNS!
       Create A record: ${local.full_domain} -> ${hcloud_server.vps.ipv4_address}

    2. Test DNS propagation:
       dig +short ${local.full_domain} @1.1.1.1

    3. Wait for cloud-init to complete:
       ssh ${var.admin_username}@${hcloud_server.vps.ipv4_address} 'cloud-init status --wait'

    4. Get your admin password with (strongly advised to change it on your VPS):
       tofu output -raw login_credentials

    5. Login to the server:
       ssh ${var.admin_username}@${hcloud_server.vps.ipv4_address} (enter your SSH key 2FA)

    6. Change the password:
       passwd

    7. Start Traefik and WordPress stack:
       cd /opt/wordpress && sudo ./setup.sh

    -> You'll receive your final instructions after running the above script

  EOT
}
