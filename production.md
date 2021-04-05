# Deployment
The application is deployed with multiple replicas in a production ready environment (AWS EKS) and using AWS ALB as production load balancer and Helm as 
kubernetes package manager.

We configured some health endpoints that allow kubernetes to check the realtime status of every instance deployed. so the Application is 100% H.A

# Scaling
Automatic Scalling can be very easily installed just enabling auto scale group in EKS terraform module. this will allow to deploy more EC2 Workers in case we are out of resources, nevertheless we already configured ```Horizontal Pod AutoScaler``` that allows kubernetes to scale up instances of the applications based on the resources used per POD.

# Logging
We should add more log tracability to the application and install log exporter to a log analyzer like Fluentd then pushed the formated data to a String based DB like Elastic Search, allow us to create our own custom metrics and alerting triggers. 

# Observability
multiple metrics are interesting to use.

- request duration: to analyze the performance
- request per status code: to analyze the realability
- source ip region: to detect where our users come from.
- number of requests per second: analyze load
- number of running instances: resources cost efectiveness.


# Monitoring
Exporting EKS metrics and application metrics to a time series DB like prometheus or influxDB, then an alert trigger system like alert manager for prometheus. 