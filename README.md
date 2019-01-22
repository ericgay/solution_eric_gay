
# DevOps Test

Simple web service to generate and save hashes. Stack:

- Rails w/ Puma app server running in clustered mode
- Nginx as a proxy terminating SSL
- Redis to store messages/hashes

## Usage

Build and start the service:

`docker-compose up`

Use the included `localhost.crt` self signed cert.

Generate a hash:

`curl --cacert localhost.crt -X POST https://localhost:5000/messages -H "Content-Type: application/json" --data '{"message": "foo" }'`
 
Get original message from hash:

`curl --cacert localhost.crt https://localhost:5000/messages/2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae`

## Testing

Use the test procedure here: https://github.com/paxosglobal/devops-test-script

Test output:

```
littlemac:devops-test-script beaker$ python ./test.py --domain localhost --port 5000 --cert-path ../localhost.crt
https://localhost:5000/messages/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa correctly not found
https://localhost:5000/messages POSTed successfully
https://localhost:5000/messages/2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae correctly found
https://localhost:5000/messages POSTed successfully
https://localhost:5000/messages/fcde2b2edba56bf408601fb721fe9b5c338d10ee429ea04fae5511b68fbf8fb9 correctly found
https://localhost:5000/messages/2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae correctly found

***************************************************************************
All tests passed!
***************************************************************************
```

## Q&A

1. How would your implementation scale if this were a high throughput service, and how could you improve that?

This will scale well. It'll scale out horizontally with ease and Redis can be scaled up or partitioned if we really needed to.

2. How would you deploy this to the cloud, using the provider of your choosing? What would the architecture look like? What tools would you use? 

I would deploy using Terrraform to AWS. I would use a standard VPC setup with ECS/Fargate running in private subnets with an ALB in front. I would offload the SSL to the ALB. ElastiCache for Redis.

3. How would you monitor this service? What metrics would you collect? How would you act on these metrics?

I would use DataDog or a similar product to monitor endpoint response time. CPU and memory consumption could also live in DataDog or CloudWatch. On the ALB side, I would monitor for 5xx responses and unhealthy hosts. I would also monitor Redis/ElastiCache for memory utilization.

