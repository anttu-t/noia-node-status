# noia-node-status
A script for checking Linux CLI NOIA node data, status and statistics

Instructions to get started
---------------------------

Notice! This script requires that you have the NOIA node running as a Linux service. 
Instructions how to set up the node service can be found in this document:
https://medium.com/@anttiturunen/set-up-noia-node-on-linux-df4a00635759

1. Log in to you node command line

2. Download the script, commands:
cd ~
curl -LO https://raw.githubusercontent.com/anttu-t/noia-node-status/master/nnstat.sh

3. Install dnsutils required for checking the external IP address:
sudo apt install dnsutils

4. Give execute rights to the script, command:
sudo chmod u+x nnstat.sh

5. Run the script (in home directory), command:
./nnstat.sh

The script output explained
---------------------------

Here is a sample script output of a running node with some explanations:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
NOIA node data, status and statistics - Sep 23 13:57:16<br />
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

Node name                atu-rpi3<br />
External IP address      2001:14bb:190:2d77:6420:ab58:7508:db95<br />
Beneficiary address      0x406cd9b0b56f3d9c9c70ca542f0968ddfbf93c4b<br />
System location          Helsinki, Finland<br />
Service provider         DNA Oyj<br />
Storage directory        /home/pi/.noia-node/storage<br />
Storage size             1 GB        <-- The amount you have defined in node.settings<br />
Uptime today             14 hours    <- Hours diagnosed OK after midnight<br />
Status checked OK        5 min ago   <- The latest time of tested OK, should be less than 1 h<br /> 
Test server address      ookla.cumulustech.co.uk<br />
Measured download speed  19 Mb/s<br />
Measured upload speed    13 Mb/s<br />
Network ping time        62 ms<br />
Cumulative uptime        262 days 20 hours  <-- All time uptime of this wallet address<br />
Total downloaded         147 MB             <-- All time downloadd data<br />
Total uploaded           9 GB               <-- All time uploaded data<br />

(Legend: Green: OK/Good, Yellow: Acceptable, Red: Not OK/Poor)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

If the node is not verified OK at all yet, the script also tests TCP port 8048 
openness to internet. Based on the test result you get either a message:

"The node is down or not verified yet. (Can take up to 1 h)

Port 8048 tested OK"

or 

"The node is down for TCP port 8048 being blocked!"

Notice! As the diagnostics by the network is run only once per hour, with a brand new node 
you may need to wait up to 1 hour before getting the data even though the node is
working perfecly.
