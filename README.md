# Devops AWS Jenkins-CI Argo-CD

## Architecture
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/c46b47a7-c30e-45f6-859e-6faa35ff3887)

## How to setup the architechture step by step
We will setup the same steps in this exercise (AWS Jenkins-CI-CD) https://github.com/vtanh1905/devops-practise/tree/aws-jenkins-cicd

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
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/603a51d1-8e5a-43c9-8626-ba2837dd1bb8)

#### 3) Get account to login
The username is **admin** (default)
We need to get password. Run the below scripts
```
kubectl get secret argocd-initial-admin-secret -n argocd -o yaml
```
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/0d183029-fdef-490f-b82e-6f5020fa832a)

Decode password in the file
```
echo  <data.password>| base64 --decode
```
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/91d19e9d-9d6d-4cad-ac69-f1845e39f417)
In my computer, my password is u6RtG2aoncVTOPLb
Finally, we are able to login
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/76b2a6c6-b45b-426e-ab54-6c761543163b)

#### 4) Create Project
After we logged, Access **Setting** on menu and then choose **Projects**
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/4f37c8b1-2c70-41ba-8605-fc7850f96427)

And then **NEW PROJECT**

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/6fa1774c-360d-4dec-8eea-188bdd44dfb0)

Create the Project the same below

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/d6ff2b3a-fc8c-4e58-b0fb-621d645e1413)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/6d4efaea-533e-4add-9506-f0cc66a2f69e)

#### 5) Create Application
Choose **Applications** on menu, click **NEW APP**

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/adafaa2f-27c2-425f-a3e0-1c3e36fd8ef9)

We choose the Project name that we have just created at the first step

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/d1d4a762-0319-4557-a8e4-ce7937b2485d)

Then click **Create** Button and we got it
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/b6ec1dde-09f3-4180-8b5f-fb8abd788700)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/77bfb982-1cad-4a07-8f4a-cbf7dda713f5)

#### 6) Deployment
Click **Sync** button and we got it
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/0acfe722-0705-43b8-bb55-231b6f1c4f3a)


## References
https://blog.devgenius.io/how-to-deploy-argocd-in-eks-cluster-for-continuous-deployment-6ebbb3009024
