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


## References
https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/
https://www.techtarget.com/searchcloudcomputing/tutorial/How-to-deploy-an-EKS-cluster-using-Terraform
https://dev.to/arunbingari/deploying-prometheus-and-grafana-using-helm-in-eks-11h2
