# Azure-getting-started
Microsoft Azure Marketplace offer - getting started with BlockApps STRATO on Azure

## BlockApps STRATO instance on Azure marketplace
- On the Azure marketplace search for the keyword "blockapps" or "strato" or "blockchain" and you'll find our listed offer (includes Test Drive).

*This individual STRATO instance (private blockchain node, self-contained and sufficient for prototyping and light POC's) also provides a RESTful web API on the HTTP port for querying your private blockchain and compiling and uploading contracts.*

## Azure Offer VM Creation
- On the VM creation screen, make sure the user-name is "strato" since the startup script is packaged for that user in the image.
![VM-Create](azure-offer-vm-create.png?raw=true "VM")

## Steps to run STRATO services on the VM created from Azure Marketplace STRATO LTS (single-node) offer

*All the setup is already done for you in the packaged VM, just run the startup script to launch the platform services.*
   
- Step 1: SSH to your newly deployed node.
- Step 4: Run strato-run script (takes about 10-20secs to see all services running, in the form of docker containers): 
```bash
$ ./strato-run.sh <FQDN of the machine>
### where FQDN is the fully qualified DNS domain name of your machine
e.g.
$ ./strato-run.sh strato-mp-instance.eastus.cloudapp.azure.com
```

### Note: if the instance services do not come up within a minute, you can restart the services using:
```bash
$ ./strato-run.sh -wipe 

$ ./strato-run.sh <FQDN of the machine>
## where FQDN is the fully qualified DNS domain name of your machine
```

The single instance will provide the following (all on port 80) with username: *admin* password: *admin*
- STRATO Management Dashboard -> http://[your server ip]
- bloc API docs -> http://[your server ip]/bloc/v2.1/docs
- STRATO API docs -> http://[your server ip]/strato-api/eth/v1.2/docs
- The strato api -> http://[your server ip]/strato-api
- A bloc instance -> http://[your server ip]/bloc/v2.1
- Cirrus search -> http://[your server ip]/cirrus/search/

Once you've the instance up and running with the API's, you can also explore and run our demo-app using your STRATO blockchain instance: https://github.com/blockapps/blockapps-ba 


## STRATO Management Dashboard
![SMD](SMD-image.png?raw=true "SMD")

