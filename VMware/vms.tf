data "vsphere_datacenter" "dc" {
  name = var.vcenter_settings.dc_name
}

data "vsphere_datastore" "datastore" {
  name          = var.vcenter_settings.datastore_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vcenter_settings.cluster_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network_web" {
  name          = var.vm_settings.portgroup # module.ACI.vsphere_portgroup_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "CentOS-Template"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm_web" {
  name             = var.vm_settings.name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_settings.num_cpus
  memory   = var.vm_settings.memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network_web.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = var.vm_settings.diskname
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.vm_settings.hostname
        domain    = var.vm_settings.domain
      }

      network_interface {
        ipv4_address = var.vm_settings.ipv4_address
        ipv4_netmask = var.vm_settings.ipv4_netmask
      }

      ipv4_gateway    = var.vm_settings.ipv4_gateway
      dns_server_list = var.vm_settings.dns_server_list
    }
  }
}

