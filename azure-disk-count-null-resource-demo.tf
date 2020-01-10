# REDEFINED VARIABLES HERE FOR THE DEMO
variable "mod_infravmname" { 
		default = "azobe"
}

variable "mod_infravmcount" { 
  default = 2 
}

variable "mod_isu_appdiskcount" { 
  default = 2 
}

locals {
  total = var.mod_infravmcount*var.mod_isu_appdiskcount# 0-base index for "count" meta
                                               # param later
  disk_names_map = zipmap(range(0,local.total),
    [for i in range(0,local.total) : format("%s%d-%02d", var.mod_infravmname, floor(i/var.mod_isu_appdiskcount), i % var.mod_isu_appdiskcount)])
}

resource "null_resource" "appdatadisk" {
#resource "azurerm_managed_disk" "appdatadisk" {
  for_each = local.disk_names_map
  triggers = { time = "${each.value}" }

  provisioner "local-exec" {
    command = "echo disk name ${each.value}"
  }

/*
  name                 = each.value
  location             = var.mod_location
  resource_group_name  = var.mod_app_rg
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.mod_isu_appdisksize
  tags                 = local.App_tags
*/  
}

resource "null_resource" "appdatadisk1_attach" {
#resource "azurerm_virtual_machine_data_disk_attachment" "appdatadisk1_attach" {
  for_each = local.disk_names_map
  triggers = { time = "${each.value}" }

  provisioner "local-exec" {
		command = "echo disk id to attach ${null_resource.appdatadisk[each.key].id}, VM : ${floor(each.key / var.mod_isu_appdiskcount)}"
  }
/*
  managed_disk_id    = azurerm_managed_disk.appdatadisk.*.id[each.index]
  virtual_machine_id = "Attach new disk for both vms that im creating with vm name-diskname format"
  lun                = 0 + count.index
  caching            = "ReadWrite" 
 */
}


resource "null_resource" "infra_server" {
# resource "azurerm_virtual_machine" "infra_server" {
  count                 = var.mod_infravmcount
  provisioner "local-exec" {
		command = "echo Creatin VM ${var.mod_infravmname}${count.index}"
  }     
/*  name                  = "${var.mod_infravmname}${count.index}"
  location              = var.mod_location
  resource_group_name   = var.mod_inf_rg
  network_interface_ids = ["${element(azurerm_network_interface.infravm_nic.*.id, count.index)}"]
  vm_size               = var.mod_inf_instance_size
*/  
}



