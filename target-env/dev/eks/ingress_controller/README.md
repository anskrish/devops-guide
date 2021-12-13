Installation guide for ingress controller
-----------------------------------------------

Execute the following in this order.

1. Create namespace for ingress controller
`kubectl apply -f 0.create-namespace.yaml`
2. Install the ingress controller
`kubectl -n apply -f 1.nginx-ingress-controller-v0.46.0.yaml`
3. Get the following details
	- CIDR of VPC
	- ARN of the SSL certificate
4. Replace these values in the `deploy-tls-termination.yaml`
	- VPC CIDR would go here -> `proxy-real-ip-cidr`
	- ARN Of VPN would go here -> `service.beta.kubernetes.io/aws-load-balancer-ssl-cert`
	- Refer to `deploy-tls-termination-dev.yaml` as an example.
5. Deploy tls termination using the command
`kubectl -n ingress-nginx apply -f 2.deploy-tls-termination-dev.yaml`
6. TLS termination is deployed. We can access endpoint over https now.
7. Route53 has to be updated to point to ingress controller.
8. Execute `kubectl -n ingress-nginx get svc` to get the load balancer external IP.
9. Add a `CNAME` record in the Route53 pointing to something like `*.service.dev.onx.ai` to rant access to all services on kubernetes using ingress controller.
