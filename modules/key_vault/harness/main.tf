module "key_vault" {
  source = "../"
  kv_map = var.kv_map
  key_vault_readers      = local.key_vault_readers
  key_vault_contributors = local.key_vault_contributors
  domain_name            = var.domain_name

  tags = var.tags
}
