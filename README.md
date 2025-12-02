# CS454-Project-2

## Docker Demo
The Docker Terraform demo uses an Nginx frontend, Python backend, and Postgres database. 

A Terraform module is used for each component. A docker_image resource is used for the backend, docker_container resources are used for the frontend, backend, and postgres database, and a docker_network ties each component together. Secrets are passed via a terraform.tfvars file, and the frontend, which directs traffic to the backend, is exposed on localhost:8080. 

### To run:
- Install Docker and Terraform
- Clone the repository
- Create terraform.tfvars containing usernames & passwords
- `terraform init` and `terraform apply`
- `curl http://localhost:8080` to verify



## K8s Demo
The Kubernetes Terraform demo uses kubectl and k3d to create and maintain a small Kubernetes cluster, using the Helm provider.

k3d is used to create and configure the cluster, and kubectl is used to monitor the cluster and verify its performance.

### To run:
- Install k3d, kubectl and Terraform
- Clone the repository
- `k3d cluster create demo-cluster`
- `k3d kubeconfig get demo-cluster > ~/.kube/config`
- `chmod 600 ~/.kube/config`
- Verify via `kubectl get nodes`
- `terraform init` and `terraform apply`
- Verify via `kubectl get all -n demo-namespace`
