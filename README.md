# AWS Jenkins-CI/CD

## Architecture
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/7791c522-6f85-4a70-9a07-e736b1919248)

## How to setup the architechture step by step
### Source that we use in this guideline
+ Frontend: https://github.com/vtanh1905/devops-practise-fe-source
+ Backend: https://github.com/vtanh1905/devops-practise-be-source
+ Deploy: https://github.com/vtanh1905/devops-practise-deploy-source

### 1) Get AWS Credentials
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/ba0dd8c9-8328-44e3-b48e-0b2332aff238)
Access "IAM" on "AWS Console" to get **access_key** and **secret_key**

### 2) Setup AWS Infrastructure by Terraform
At the roor of reponsitory, we run the below script
```
cd terraform
terraform apply
```
And then enter the **access_key** and **secret_key** which we got the above.

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/95d1c76e-95cc-4e1e-ad72-cbf244f6b8ea)

**Note**: We should take a rest or prepare the coffee because it takes 20-25 minutes
Finally, we got it.

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/afec1e72-3919-4b97-bb8b-08199cab54da)


### 3) Setup Jenkins
Access the jenkin_url which we got above after we ran the script

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/ae878373-79a2-4186-a3c9-870868316a0c)

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
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/ed7444ff-ea90-46c0-88f6-f8b12031bcec)
In my ec2,the password is 6fe3c31d62d6411ab526b8f69918fa2d 

#### 3.2) Getting Started with Jenkins
After we logged the Jenkins, choose **Install suuggested plugins**
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/9419e9bc-fe7c-43b7-9a89-5f0d8660ad30)

After that, we fullfill the form 
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/5da61e13-44f2-40b0-8a4c-458c6c857337)

Finllay, click **Save and Continue** and next click **Save and Finish**

#### 3.3 Config Github Webhook for Jenkin
Why we have to setup this, because we update new code in our source. The Jenkin run automatically CI.

First, go to **Github Page** and Login your personal account -> Go to **Setting** -> Choose **Developer Settings** -> **Token (classic)** -> **Generate new token (classic)** ->  Generate token with **admin:org_hook** permission
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/a9e76089-59b4-4bc7-910b-14af6e068660)

Second, go to the **our source** on Github -> **Setting** -> **Webhook** -> **Add webhook**
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/3a24bd67-2d04-4207-a0b4-923e82f62d48)

+ **Payload URL**: **${Jenkin_URL}**/github-webhook/

Third, go to **Dashboard** Page -> Click **Manage Jenkins** -> Choose **System** -> Move to **Github** Section
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/cd89c3eb-918f-432c-abcf-7a2f16d2a397)

Then, Add **Credentials** (note: Secret is the webhook token which is generated above)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/a7be6d39-579f-4ad2-9db9-9d5589b229e4)

Finally, press **Save** button
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/357a6c23-fd46-450c-99ee-c9da28c77009)

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

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/ea9d997f-7bfe-408d-8cbf-aa6c58cb3b53)

Second, in **Projects** Section, we will add 3 repositories (frontend, backend, deploy)

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/b4dbeed8-1b86-4d36-8180-9bc9f2bb2ae4)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/3e9d0579-9a21-4736-9a4f-c0dcea745172)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/b3f5f85a-f005-4524-940d-5b8102720e89)

Third, add **Credential** to autherization (Username and Password Github)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/fc0e5670-2bf1-470a-9f36-6bbe222a3adb)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/3d01a397-b711-4cd3-b5f4-cf35dc678808)

Finally, we see the same below
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/27fa493c-0197-456e-8c19-dca739ca052d)

#### 3.6) Config ECR and EKS on Jenkin
At **Dashboard** page -> Choose **Manage Jenkins** on Menu -> Click **Credentitals** -> Add **Credentials**
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/c9494751-246b-4877-8860-a019cc858c68)

First, add **AWS Credentitals**
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/44a0761d-ebee-48b7-b833-11fa1741e97e)

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
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/34dbbe39-d5dc-4d1f-a366-3f099e9c7298)

Add 5 Variable Environment (**AWS_ACCESS_KEY_ID**, **AWS_SECRET_ACCESS_KEY**, **ECR_CREDENTIALS**, **ECR_URL**, **EKS_SERVER_URL**) like the same above

#### 3.8) Modify Image tag and Environment in Deploy Source
Modify **deployment.yaml** in deploy source
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/db574bac-c8bf-4289-b43d-73793fdf48cd)

#### 3.9) Trigger the pipeline again
We will got the resut the same below
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/dbe1c8df-b31b-4be5-b8c5-6d3d4db7d00d)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/b900b2ef-e310-49af-8b0e-2cf598b284fa)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/3872466f-8560-4ef8-aa72-5f267bb5e26c)
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/1d1ac0b9-d35d-43a1-8e02-876c4f88ad2e)


### 4) Install Prometheus

## References
https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/
https://www.techtarget.com/searchcloudcomputing/tutorial/How-to-deploy-an-EKS-cluster-using-Terraform
https://dev.to/arunbingari/deploying-prometheus-and-grafana-using-helm-in-eks-11h2
