@echo off
NETSH advfirewall firewall delete rule name="Remote Desktop (TCP-In)"
NETSH advfirewall firewall add rule name="Remote Desktop (TCP-In)" program=System profile=public,private,domain dir=in localport=3389 protocol=tcp action=allow description="Inbound rule for the Remote Desktop service to allow RDP traffic. [TCP 3389]"

 
