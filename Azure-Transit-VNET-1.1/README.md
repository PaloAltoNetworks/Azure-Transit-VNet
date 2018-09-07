

![alt_text](documentation/images/pan-logo-badge-green-dark-kick-up.png "logo")

# Azure Transit VNet with the VM-Series

- Now supports bootstrapping in both Hub and Spoke 
- Now supports auto scaling with Azure Virtual Machine Scale Sets in the Spoke
- Does NOT support autoscaling in the Transit HUB at this time



The Azure Transit VNet with the VM-Series deploys a hub and spoke architecture to centralize commonly used services such as security and secure connectivity. All traffic to and from the Spokes will “transit” the Hub VNet and will be protected by the VM-Series next generation firewall. To get started, the Hub VNet must be deployed first with the Spoke VNets being deployed subsequently. Once the Spoke is deployed, the VNets are dynamically peered to allow cross VNet communication. For more information on deployment please see the [Deployment Guide](https://github.com/PaloAltoNetworks/Azure-Transit-VNet/blob/master/Azure-Transit-VNET-1.1/documentation/Azure_Transit_VNet1.1_Deployment_Guide.pdf).


# Hub VNet
The Hub VNet is deployed exclusively to handle outbound traffic that originates from within the Hub or Spoke VNet. This outbound work flow not only segments traffic that originates from outside of the VNet, but it also ensures that only whitelisted external requests are allowed by leveraging VM-Series security policies. By providing a single exit point for traffic originating within your VNets you can ensure that all outbound traffic is secured to the standards required by your organization. 

This topology consists of
-	2 VM-Series Firewalls
-	1 Standard internal Load Balancer
-	Linux Worker Node
	-	Worker node uses the Tabular storage table to keep track of the Azure VMSS table located in the spoke and Panorama device list. During a scale down event the worker node will deactivate the license in the Support Portal and remove the firewall from Panorama. 
	-	The worker node updates the NAT address object in the Spoke VM-series with the correct IP address of the spoke ILB. 
	-	The worker node will add the Azure instrumentation key for application insights into the Panorama template for reach new spoke deployment. 
-	1 Tabular Storage Table
	-	Stores VMSS device list data




[<img src="http://azuredeploy.net/deploybutton.png"/>](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPaloAltoNetworks%2FAzure-Transit-VNet%2Fmaster%2FAzure-Transit-VNET-1.1%2Fazure-hub%2FazureDeployInfra.json?token=AZoiWUdo2qPkcTjMXpY8_KOkrP2aBqp_ks5ahJwcwA%3D%3D)

![alt_text](documentation/images/Hub-Topology.PNG "topology")

# Spoke VNet
Using the Spoke VNet template, you can deploy as many Spokes as needed to host internal only, or public facing workloads. Return traffic from inbound web access requests will traverse the same path it was received, and traffic originating from the Hub and Spoke networks will exit the hub VNet exclusively.

This topology consists of
-	1 Application Gateway functioning as an external load balancer listening on port 80. 
-	Spoke subnets are 192.168.0.0/21 Spoke1, 192.168.8.0/21 Spoke2 and so on.
-	Virtual Machine Scale Set with a VM-Series
-	Availability Set for VM-Series
-	1 Internal Load Balancer
-	2 Linux Web servers
-	1 UDR sending all default route traffic to the Hub VNet Standard Load Balancer.

-	1 Bastion host
	-	Used to connect to VM-Series firewalls in the VMSS via private Mgmt interface IP
-	Application insights
	-	Used to process VM-Series metrics used to determine scale in & scale out events


# With VM-Series Firewall 

[<img src="http://azuredeploy.net/deploybutton.png"/>](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPaloAltoNetworks%2FAzure-Transit-VNet%2Fmaster%2FAzure-Transit-VNET-1.1%2Fazure-spoke%2Fazuredeploy.json?token=AZoiWXZHIcxPcJG4iqbfyOUvHN1O8coUks5ahgGXwA%3D%3D)


![alt_text](documentation/images/Spoke-Topology.PNG "topology")

# Without VM-Series Firewall

[<img src="http://azuredeploy.net/deploybutton.png"/>](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPaloAltoNetworks%2FAzure-Transit-VNet%2Fmaster%2FAzure-Transit-VNET-1.1%2Fazure-spoke%2Fazuredeploy-no-firewall.json?token=AZoiWXZHIcxPcJG4iqbfyOUvHN1O8coUks5ahgGXwA%3D%3D)


# Deployment guide
The deployment guide can be found [here](https://github.com/PaloAltoNetworks/Azure-Transit-VNet/blob/master/Azure-Transit-VNET-1.1/documentation/Azure_Transit_VNet1.1_Deployment_Guide.pdf)

Bootstrap the VM-Series Firewall on Azure [Bootstrap Instructions](https://www.paloaltonetworks.com/documentation/81/virtualization/virtualization/bootstrap-the-vm-series-firewall/bootstrap-the-vm-series-firewall-in-azure#idd51f75b8-e579-44d6-a809-2fafcfe4b3b6)



# Support Policy: Community-Supported
The code and templates in this repository are released under an as-is, best effort, support policy. These scripts should viewed as community supported and Palo Alto Networks will contribute our expertise as and when possible. We do not provide technical support or help in using or troubleshooting the components of the project through our normal support options such as Palo Alto Networks support teams, or ASC (Authorized Support Centers) partners and backline support options. The underlying product used (the VM-Series firewall) by the scripts or templates are still supported, but the support is only for the product functionality and not for help in deploying or using the template or script itself. Unless explicitly tagged, all projects or work posted in our GitHub repository (at https://github.com/PaloAltoNetworks) or sites other than our official Downloads page on https://support.paloaltonetworks.com are provided under the best effort policy.

