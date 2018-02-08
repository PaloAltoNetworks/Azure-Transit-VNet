# Azure Transit vNet

This solution deploys both a Hub vNet and Spoke vNet within the Microsoft Azure cloud framework. Both virtual networks are secured by Palo Alto Networks VM-Series firewalls and Azure Network Security Groups for management access. 

# Hub vNet
The Hub vNet is deployed exclusively to handle outbound traffic which originates from within the Hub or spoke vNet environments. This outbound work flow not only separates traffic that originates from outside of the hub and spoke networks but also ensures that only whitelisted external requests are allowed by leveraging Palo Alto Networks Next Generation Firewall capabilities. By providing a single exit point for traffic originating within topology you can ensure that all outbound traffic meets the security standards required to be enforced. 

This topology consists of
- 2 VM-Series Firewalls
- 1 Standard Outbound Loadbalancer
- 1 UDR sending all default route traffic to the Standard Loadbalancer

# Spoke vNet
The Spoke vNet can be deployed to host public facing workloads as well as non public facing workloads. More than one spoke can be deployed by launching the spoke template multiple times. Please note that all return traffic from inbound web access requests to public facing spoke resources will return through the same path it was received. Only traffic originating from the hub and spoke networks will exit the hub vNet. 

This topology consists of
- 1 Application Gateway listening on port 80. The App Gateway also functions as a public facing external load balancer
- 2 VM-Series Firewalls
- 1 Internal Loadbalancer
- 2 Linux Web servers
- 1 UDR sending all default route traffic to the Hub vnet Standard Loadbalancer.




![alt_text](documentation/images/TransitvNetFlow-2.PNG "topology")

# Deployment guide
The deployment guide can be found [here](https://github.com/PaloAltoNetworks/Azure-Transit-VNET/blob/master/documentation/Azure_Transit_vNet_Deployment_Guide.pdf)

# Support Policy
The code and templates in the repo are released under an as-is, best effort, support policy. These scripts should be seen as community supported and Palo Alto Networks will contribute our expertise as and when possible. We do not provide technical support or help in using or troubleshooting the components of the project through our normal support options such as Palo Alto Networks support teams, or ASC (Authorized Support Centers) partners and backline support options. The underlying product used (the VM-Series firewall) by the scripts or templates are still supported, but the support is only for the product functionality and not for help in deploying or using the template or script itself. Unless explicitly tagged, all projects or work posted in our GitHub repository (at https://github.com/PaloAltoNetworks) or sites other than our official Downloads page on https://support.paloaltonetworks.com are provided under the best effort policy.
