# Devops AWS Jenkins-CI Argo-CD

## Architecture
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/7b66ef63-7c83-4c30-b12a-898b8b51fa75)

## How to setup the architechture step by step
We will setup the same steps in this exercise (AWS Jenkins-CI-CD)
```
https://github.com/vtanh1905/devops-practise/tree/aws-jenkins-cicd
```
However, we ignore the **3.6** step and **3.9** step.

We will replace that with **Setup ArgoCD**

### Setup ArgoCD
#### 1) Install ArgoCD
We run this scripts
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

#### 2) Forward Port
```
kubectl port-forward svc/argocd-server 8080:443 -n argocd
```
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/7785edf2-1ae8-46d7-b81f-7c00f9a11e71)

#### 3) Get account to login
The username is **admin** (default)
We need to get password. Run the below scripts
```
kubectl get secret argocd-initial-admin-secret -n argocd -o yaml
```
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/3deee86d-3a15-4ec8-85c0-935e7a5d88d5)

Decode password in the file
```
echo  <data.password>| base64 --decode
```
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/ded02fa6-bda7-4a06-9a04-43f71e5cbc11)

In my computer, my password is u6RtG2aoncVTOPLb

Finally, we are able to login

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/7def6017-3933-4707-bd85-07569469f495)


#### 4) Create Project
After we logged, Access **Setting** on menu and then choose **Projects**

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/604e9fd3-bd66-4cf7-b645-461b336613c5)


And then **NEW PROJECT**

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/67c169d0-fe49-4f16-ac1f-dcae547b6246)

Create the Project the same below

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/c48365a9-a4e7-4d29-a845-9020c194c6ce)

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/d3c39e62-514e-4db6-863a-1c8bae3e7912)

#### 5) Create Application
Choose **Applications** on menu, click **NEW APP**

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/8571d58d-fb42-4edc-8cba-b3c8a6ee56b8)

We choose the Project name that we have just created at the first step

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/1ce1b80c-e4b7-4805-80ed-71198a6ae432)

Then click **Create** Button and we got it

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/1340322d-59db-4979-ab2c-643197ed764d)

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/3748096b-7804-482c-9407-b1d61ef007ba)

#### 6) Deployment
Click **Sync** button and we got it

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/b81ea974-e1c4-4424-860c-f3dce42c07dd)


## References
https://blog.devgenius.io/how-to-deploy-argocd-in-eks-cluster-for-continuous-deployment-6ebbb3009024
