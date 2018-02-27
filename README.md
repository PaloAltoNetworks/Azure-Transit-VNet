

![alt_text](documentation/images/pan-logo-badge-green-dark-kick-up.png "logo")

# Azure Transit VNet

This solution deploys both a Hub and Spoke VNet within the Microsoft Azure cloud framework. Both Hub and Spoke virtual networks are secured by Palo Alto Networks VM-Series firewalls. The Hub VNet provides secured centralized outbound access for all traffic originating within your Azure virtual networks. The Spoke VNet can provide secured inbound access for public facing workloads for each Spoke VNet individually. The Hub VNet must be deployed first with the Spoke VNets being deployed subsequently. Once the spoke is deployed the VNets are dynamically peered to allow cross VNet communication. For more information on deployment please see the Deployment Guide.


# Hub VNet
The Hub VNet is deployed exclusively to handle outbound traffic that originates from within the Hub or Spoke Virtual Networks. This outbound work flow not only segments traffic that originates from outside of the VNet, but it also ensures that only whitelisted external requests are allowed by leveraging Palo Alto Networks Next Generation Firewall technology. By providing a single exit point for traffic originating within your virtual networks you can ensure that all outbound traffic is secured to the standards required by your organization.  

This topology consists of
- 2 VM-Series Firewalls
- 1 Standard Outbound Loadbalancer

[<img src="http://azuredeploy.net/deploybutton.png"/>](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPaloAltoNetworks%2FAzure-Transit-VNET%2Fmaster%2Fazure-pan-hub%2FazureDeployInfra.json?token=AZoiWUdo2qPkcTjMXpY8_KOkrP2aBqp_ks5ahJwcwA%3D%3D)

![alt_text](documentation/images/Hub-Topology.PNG "topology")

# Spoke VNet
The Spoke VNet can be deployed to host public facing workloads as well as non public facing workloads. More than one spoke can be deployed by launching the spoke template multiple times. Please note that all return traffic from inbound web access requests will return through the same path it was received. Only traffic originating from the Hub and Spoke networks will exit the hub VNet exclusively. 

This topology consists of
- 1 Application Gateway listening on port 80. The App Gateway also functions as a public facing external load balancer
- 2 VM-Series Firewalls
- 1 Internal Loadbalancer
- 2 Linux Web servers
- 1 UDR sending all default route traffic to the Hub vnet Standard Loadbalancer.

[<img src="http://azuredeploy.net/deploybutton.png"/>](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPaloAltoNetworks%2FAzure-Transit-VNET%2Fmaster%2Fazure-pan-spoke%2Fazuredeploy.json?token=AZoiWXZHIcxPcJG4iqbfyOUvHN1O8coUks5ahgGXwA%3D%3D)

![alt_text](documentation/images/Spoke-Topology.PNG "topology")


# Deployment guide
The deployment guide can be found [here](https://github.com/jpeezus/Azure-Transit-VNet/blob/master/documentation/Azure_Transit_VNet_Deployment_Guide.pdf)


# Support Policy
The code and templates in the repo are released under an as-is, best effort, support policy. These scripts should be seen as community supported and Palo Alto Networks will contribute our expertise as and when possible. We do not provide technical support or help in using or troubleshooting the components of the project through our normal support options such as Palo Alto Networks support teams, or ASC (Authorized Support Centers) partners and backline support options. The underlying product used (the VM-Series firewall) by the scripts or templates are still supported, but the support is only for the product functionality and not for help in deploying or using the template or script itself. Unless explicitly tagged, all projects or work posted in our GitHub repository (at https://github.com/PaloAltoNetworks) or sites other than our official Downloads page on https://support.paloaltonetworks.com are provided under the best effort policy.
