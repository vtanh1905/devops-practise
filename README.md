## Architecture
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/7791c522-6f85-4a70-9a07-e736b1919248)

## How to setup the architechture step by step
### Source that we use in this guideline
+ Frontend: https://github.com/vtanh1905/devops-practise-fe-source
+ Backend: https://github.com/vtanh1905/devops-practise-be-source
+ Deploy: https://github.com/vtanh1905/devops-practise-deploy-source

### 1) Get AWS Credentials
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/e70ed81a-18fa-4adb-ac28-50eac3275bce)

Access "IAM" on "AWS Console" to get **access_key** and **secret_key**

### 2) Setup AWS Infrastructure by Terraform
At the roor of reponsitory, we run the below script
```
cd terraform
terraform apply
```
And then enter the **access_key** and **secret_key** which we got the above.

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/dcb776c9-b265-4a88-9496-5ab91697d273)

**Note**: We should take a rest or prepare the coffee because it takes 20-25 minutes
Finally, we got it.

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/8059df26-a808-4e2a-a2db-4ed599f82075)

### 3) Setup Jenkins
Access the jenkin_url which we got above after we ran the script

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/a99b8ad9-428d-4287-8d1a-a656ea27a29e)

#### 3.1) How to get password
SSH into the ec2 which we got it after running the terraform.
```
ssh -i tf_key_pair.pem ec2-user@<ec2-public-ip>
```
**Note**: The key pair file is generated after running the terraform, it's in the terraform folder

And then, run this script in the terminal of ec2
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/0d6d8184-cec0-4470-93e2-21c52ce0272a)

In my ec2,the password is 6fe3c31d62d6411ab526b8f69918fa2d 

#### 3.2) Getting Started with Jenkins
After we logged the Jenkins, choose **Install suuggested plugins**
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/149d3463-8090-4137-b79b-2ed403a8a2aa)

After that, we fullfill the form 
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/3aac4e8f-b5d9-495b-a75d-a9f0d5d3390f)

Finllay, click **Save and Continue** and next click **Save and Finish**

#### 3.3 Config Github Webhook for Jenkin
Why we have to setup this, because we update new code in our source. The Jenkin run automatically CI.

First, go to **Github Page** and Login your personal account -> Go to **Setting** -> Choose **Developer Settings** -> **Token (classic)** -> **Generate new token (classic)** ->  Generate token with **admin:org_hook** permission

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/8f636c9c-683d-4c3e-91eb-3fd71f580ec1)

Second, go to the **our source** on Github -> **Setting** -> **Webhook** -> **Add webhook**

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/dc7875d1-ec16-40c0-a342-ac88ae22796b)

+ **Payload URL**: **${Jenkin_URL}**/github-webhook/

Third, go to **Dashboard** Page -> Click **Manage Jenkins** -> Choose **System** -> Move to **Github** Section

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/420ba02f-0f15-48ac-b5b7-78ab91dcb843)

Then, Add **Credentials** (note: Secret is the webhook token which is generated above)

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/044160ad-8c88-48bb-9657-fb738e84e857)

Finally, press **Save** button

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/ca54a9ae-37d1-4cf3-bf71-f6d469f33958)

#### 3.4) Install Plugins for Jenkin
Go to **Manage Jenkins** -> **Plugins** -> **Available plugins**
Install the below plugins
+ Docker
+ Docker Pipeline
+ CloudBees AWS Credentials
+ Amazon ECR
+ Kubernetes CLI

#### 3.5) Create CI on Jenkin
First, at **Dashboar** Page -> Choose **New Item** on Menu -> Fill the name -> Choose **Organization Folder** ->  **OK**

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/a55e448a-21b9-4b91-89ab-55d3c2ce7289)

Second, in **Projects** Section, we will add 3 repositories (frontend, backend, deploy)

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/77d81be0-f701-44bf-9b5e-7e76f3202f6a)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/f5ec4945-a17d-4dac-ae43-d1b571f0a2c0)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/d4cf1197-42eb-4816-a8ce-43f1ad6075e5)

Third, add **Credential** to autherization (Username and Password Github)

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/b8e79663-9d08-4baa-8487-be7a51e3eb18)

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/94e93a5e-5b36-4706-90cc-808764d28c49)

Finally, we see the same below
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/2522153e-c855-43d5-b95e-1962ae47d199)

#### 3.6) Config ECR and EKS on Jenkin
At **Dashboard** page -> Choose **Manage Jenkins** on Menu -> Click **Credentitals** -> Add **Credentials**

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/91d000c0-ba88-4260-824b-07360ae6653d)

First, add **AWS Credentitals**

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/2f0973de-4dc7-446a-a30f-07cfef96aeb5)

Second, config EKS config for Kubectl
+ SSH into EC2 Jenkin
```
ssh -i tf_key_pair.pem ec2-user@<ec2-public-ip>
```
+ Run this command
```
aws eks update-kubeconfig --region ap-southeast-1 --name devops-eks-cluster
sudo cp ~/.kube/config ~jenkins/.kube/
sudo chown -R jenkins: ~jenkins/.kube/
```

#### 3.7) Add Global Environment Variable On Jenkin
At **Dashboard** page -> Move to **Manage Jenkins** -> Click **System** -> Scroll down to **Global properties**

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/dfd778de-2af9-4584-808a-a4b9ac225714)

Add 5 Variable Environment (**AWS_ACCESS_KEY_ID**, **AWS_SECRET_ACCESS_KEY**, **ECR_CREDENTIALS**, **ECR_URL**, **EKS_SERVER_URL**) like the same above

#### 3.8) Modify Image tag and Environment in Deploy Source
Modify **deployment.yaml** in deploy source

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/ecc319fd-b45e-453b-92ee-96e24b3e59bb)


#### 3.9) Trigger the pipeline again
We will got the resut the same below

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/44e066eb-0a6c-49a8-a653-42e8c2b22f26)

And then we commit and push to github. And we got it

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/5e9ae5f0-a91d-4a6e-a8e2-d464ae9ecd6e)

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/c9aea432-97aa-44e5-9800-49f5d7fb9848)

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/c529d15e-4d33-4d59-a856-827d4d9395a3)



### 4) Setup Prometheus
On your PC or your ec2 that we installed jenkin
First, install **Helm**
```
wget https://get.helm.sh/helm-v3.12.3-linux-amd64.tar.gz
tar xvf helm-v3.12.3-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin
```
Second, install **Prometheus**
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
kubectl create namespace monitoring
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring
```
After that, we got it
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/f419326a-71ff-428b-aad9-522b3d6216a8)

Third, we can forward port to access 
```
kubectl port-forward prometheus-prometheus-kube-prometheus-prometheus-0 9090 -n monitoring
```
And then access this link: http://localhost:9090
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/2170654d-6231-41f4-ac92-57cbe81493ec)

### 5) Setup Grafana
First, install Grafana
```
helm install grafana grafana/grafana --namespace monitoring
```
After that, we got it
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/9dd894b5-1cf0-4dab-83ab-24b3a3724fc3)

Second, we can forward port to access
```
kubectl port-forward svc/grafana 3000:80 -n monitoring
```
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/bb0899a1-63af-4bcf-b925-4130c54c0370)

Third, need account to login
Default username is **admin**
And run this script to get password
```
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```
Finally, we logged the Grafana
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/699f32ba-dd30-4fd2-b4f2-3759eb4974ed)

## References
https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/
https://www.techtarget.com/searchcloudcomputing/tutorial/How-to-deploy-an-EKS-cluster-using-Terraform
https://dev.to/arunbingari/deploying-prometheus-and-grafana-using-helm-in-eks-11h2
