Solution – Question 1
While both `nmtui` and `nmcli` are fully acceptable and score equally, this solution uses `nmtui` for its efficiency and reduced risk of error in a timed exam environment. Candidates are free to use the method they are most comfortable with.
Preparation
Identify the current network configuration by running the command:
```bash
ip a
```
Example output:
```
... inet 172.16.18.142/24 ... 
```
Interpretation:
Subnet mask: `/24` → `255.255.255.0`
Network ID: `172.16.18.0/24`
Host ID: `142`
To remain within the same local network, select an unused host address in this range. The chosen configuration that aligns with the task to use Host ID of 50 is:
IP address: `172.16.18.50/24`
Gateway: `172.16.18.1`
Solution
Step 1 — Edit the Network Connection
Launch the Network Manager TUI:
```bash
nmtui
```
Select Edit a connection
Choose the active interface (e.g. `ensXXX`) → Edit
Navigate to IPv4 CONFIGURATION
Change method from Automatic to Manual
Select Show
Step 2 — Apply IPv4 Settings
Enter the required values:
Addresses: `172.16.18.50/24`
Gateway: `172.16.18.1`
DNS servers: `8.8.8.8`
Search domains: `example.local`
Select OK, then exit.
Step 3 — Activate the Configuration (Critical)
Configuration changes do not take effect until the connection is reactivated.
From the main `nmtui` menu, select Activate a connection
With `ensXXX` selected:
Deactivate
Activate
Exit
> **Note:** Failure to activate the connection could result in zero networking points.
Step 4 — Set the Hostname
Choose one of the following methods:
Using nmtui:
Select Set system hostname
Enter and save: `rhel-node1.example.com`
OR using the command line (Preferred):
```bash
hostnamectl set-hostname rhel-node1.example.com
```
OR
```bash
hostnamectl hostname rhel-node1.example.com
```
Step 5 — Ensure NetworkManager Is Enabled
Ensure NetworkManager is running and enabled at boot:
```bash
systemctl enable --now NetworkManager
systemctl restart NetworkManager
```
Verification
Confirm the configuration:
```bash
ip a             # Confirm the IP address
ip route         # Confirm the default gateway address
```
Verify the hostname:
```bash
hostname
```
OR
```bash
cat /etc/hostname
```
Exam Note
In the actual RHCSA exam, the IP details are explicitly provided. This approach demonstrates how to ensure the assigned address resides within the local subnet. Using an incorrect or out-of-range IP may isolate the system and break essential services such as SSH, ICMP, and DNS resolution, or even communication between different nodes.
Remember to always include the network mask in the IP address configuration `172.16.18.50/24`. That means if the subnet mask is given as `255.255.255.0`, you should include `/24` at the end of the static IP address.
