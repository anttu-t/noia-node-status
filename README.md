# noia-node-status
A script for checking Linux CLI NOIA node data, status and statistics

Instructions to get started
---------------------------

1. Log in to you node command line
2. Download the script, command:
3. Give execute rights to the script, command:
4. Run the script, command: 

The script output explained
---------------------------

Here is the script output of a running node with some explanations:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
NOIA node data, status and statistics - Sep 23 13:57:16<br />
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

Node name                atu-rpi3<br />
External IP address      176.93.49.39<br />
Beneficiary address      0x406cd9b0b56f3d9c9c70ca542f0968ddfbf93c4b<br />
System location          Helsinki, Finland<br />
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
