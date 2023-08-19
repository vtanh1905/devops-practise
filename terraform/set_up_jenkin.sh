#!/bin/bash
sudo yum update –y

# Install Git
sudo yum install git -y

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum upgrade

sudo dnf install java-11-amazon-corretto -y

sudo yum install jenkins -y

sudo systemctl enable jenkins

sudo systemctl start jenkins

# Install Docker
sudo yum install docker -y

sudo systemctl start docker

sudo systemctl enable docker

# Gain Permission Docker to Jenkins
sudo usermod -a -G docker jenkins

sudo systemctl restart jenkins

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin

# Install Helm
# wget https://get.helm.sh/helm-v3.12.3-linux-amd64.tar.gz
# tar xvf helm-v3.12.3-linux-amd64.tar.gz
# sudo mv linux-amd64/helm /usr/local/bin

# Install ArgoCD
# kubectl create namespace argocd
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Forward Port ArgoCD
# kubectl port-forward svc/argocd-server 8080:443 -n argocd

# Install ArgoCD CLI
# curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
# sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
# rm argocd-linux-amd64