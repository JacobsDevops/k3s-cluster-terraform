# K3s
Lightweight Kubernetes. Easy to install, half the memory, all in a binary of less than 100 MB.

# Install Script Server Node
K3s provides an installation script that is a convenient way to install it as a service on systemd or openrc based systems. This script is available at https://get.k3s.io. To install K3s using this method, just run:

curl -sfL https://get.k3s.io | sh -


# To install additional agent nodes to the cluster
 run the installation script with the K3S_URL and K3S_TOKEN environment variables. Here is an example showing how to join an agent:

curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -

> On your server node the value to use for K3S_TOKEN is stored at:
/var/lib/rancher/k3s/server/node-token 

# Requirements

Hardware
The minimum requirements are:

| Node   | CPU   | RAM |
| ------ | ------| --- |
| Server | 2     | 2 GB |
| Agent  | 1     | 512 MB |


Server Sizing Guide

| Server-CPU | Server-RAM | Number of Agents |
| ------     | ------     | ------
|    2       |    4 GB    | 0-350            |
|    4       |    8 GB    | 351-900          |



Networking
The K3s server needs port 6443 to be accessible by all nodes.

For all inbound rules:
https://docs.k3s.io/installation/requirements?os=debian#networking