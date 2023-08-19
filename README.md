# AWS Jenkins-CI/CD

## Architecture
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/7791c522-6f85-4a70-9a07-e736b1919248)

## How to setup the architechture step by step
### 1. Get AWS Credentials
![image](https://github.com/vtanh1905/devops-practise/assets/49771724/ba0dd8c9-8328-44e3-b48e-0b2332aff238)
Access "IAM" on "AWS Console" to get **access_key** and **secret_key**

### 2. Setup AWS Infrastructure by Terraform
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


### 3. Setup Jenkins
Access the jenkin_url which we got above after we ran the script

![image](https://github.com/vtanh1905/devops-practise/assets/49771724/ae878373-79a2-4186-a3c9-870868316a0c)

#### 3.1 How to get password
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

#### 3.2 Getting Started with Jenkins
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


## References
https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/
https://www.techtarget.com/searchcloudcomputing/tutorial/How-to-deploy-an-EKS-cluster-using-Terraform
https://dev.to/arunbingari/deploying-prometheus-and-grafana-using-helm-in-eks-11h2
