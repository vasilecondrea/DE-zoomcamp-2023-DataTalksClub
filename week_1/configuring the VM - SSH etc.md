
# Configuring the VM for the course
following this: https://www.youtube.com/watch?v=ae-CV2KfoN0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&ab_channel=DataTalksClub%E2%AC%9B

**Why do I need an SSH in the first place?**

SSH keys enable the automation that makes modern cloud services and other computer-dependent services possible and cost-effective. They offer convenience and improved security when properly managed. Functionally SSH keys resemble passwords. They grant access and control who can access what.


**Create ssh key**

start from google docs: run ``ssh-keygen -t rsa -f FILENAME -C USERNAME -b 2048`` in the shell in the .ssh/ directory (if you do not put a password it will not ask for one)

**put the public key (of the two keys created) into the GC account**
1. On GC go to Compute engine, select metadata, and select ssh tab in the following screen
2. go to your shell `cat gcp.pub` and copy paste the output into the ssh tab
3. Output from CGP "All instances in this project inherit these SSH keys. Learn more" -- all virtual machines under thi project will use this ssh key

**create the VM from the console**
but one can use this piece of code as well from the shell

`gcloud compute instances create de-zoomcamp --project=NAMNEOFPROJECT --zone=europe-west6-a --machine-type=e2-standard-4 --network-interface=network-tier=PREMIUM,subnet=default --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=699002165479-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=de-zoomcamp,image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20230125,mode=rw,size=30,type=projects/NAMNEOFPROJECT/zones/europe-west6-a/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any`


**once the machine is created**
go to your shell and type `ssh -i ~/.ssh/gcp USERNAME-USED-FOR-SSHKEY@EXTERNAL-IP-ADDRESS-FROM-CLOUD`

**downloand anacoda into the new machine**

**open another terminal and create file "config" in the .ssh folder to access easily you VM on gcloud"**

do `cd .ssh/ 
touch config
code config
`
in the config file write 
`
Host NAME-OF-MACHINE('de-zoomcamp' for this instance)
    HostName THE-EXTERNAL-IP-OF-VM
    User THE-NAME-USED-FOR-THE-MACHINE
    IdentityFile ~/.ssh/gcp`


**now you can connect to CGP VM from terminal home directory by typing `ssh de-zoomcamp`** 

**logout** 
this `logout` logs out from CGP VM
to reconnect do `ssh de-zoomcamp` (or 'ssh NAME-INSERTED-in-the-config-file')

**check your python**
`which python
importa pandas as pd
pd.__version__` this gives you the version of pandas
then
if you do not want to log to python all the time do 

`source .bashrc` - this creates a sort of venv?


To work directly on the VM in the cloud install an extension in VS code "remote ssh"