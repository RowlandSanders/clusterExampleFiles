# 🎬 CI/CD Streaming Service Example

This repository demonstrates how a modern **CI/CD toolchain** can be orchestrated to support a highly available, scalable **on-demand video streaming platform**.  
It showcases how each tool integrates into the pipeline, from code commit to deployment, monitoring, and scaling.

---

## 🚀 Objectives
- Automate builds, testing, and deployments.
- Use infrastructure as code for repeatable environments.
- Ensure high availability and autoscaling for streaming workloads.
- Provide end-to-end observability and monitoring.

---

## 🛠️ Toolchain Overview

### 📂 Source Control
- **Bitbucket/Git** – Version control and pull request workflow.

### ⚙️ Build & CI
- **Jenkins** – Automates build, test, and packaging of the Java streaming service.
- **Gradle** – Build tool for compiling and testing the application.

### 📦 Artifact Management
- **JFrog Artifactory** – Stores Docker images and Helm charts for versioned deployments.

### ☸️ Containerization & Orchestration
- **Docker** – Packages services (streaming app, Redis, Kafka, etc.) into portable containers.
- **Helm** – Manages Kubernetes deployments with versioned charts.
- **Kubernetes (Rancher-managed)** – Runs workloads across master/worker nodes.

### 🔑 Provisioning
- **Ansible** – Automates infrastructure configuration (nodes, networking, secrets).

### 📊 Monitoring & Scaling
- **Prometheus & Grafana** – Collect metrics and visualize cluster health.
- **Redis & KEDA/HPA** – Enables event-driven autoscaling based on user load.

---

## 🔄 CI/CD Workflow

1. **Code Commit** → Developer pushes to Bitbucket.
2. **Build Stage** → Jenkins compiles with Gradle and runs tests.
3. **Package Stage** → Docker images built and pushed to Artifactory.
4. **Deploy Stage** → Helm charts pulled from Artifactory and deployed to Kubernetes.
5. **Provisioning** → Ansible ensures environments and secrets are consistent.
6. **Observability** → Prometheus scrapes metrics, Grafana dashboards visualize usage.
7. **Autoscaling** → Redis + HPA/KEDA triggers scale-out of pods based on active video streams.

---

## 📡 Streaming Service Architecture

- **Frontend Service** → Receives user requests.
- **Encoding Service** → Encodes video on-demand.
- **Delivery Service** → Streams content to clients.
- **Analytics Capture** → Tracks usage and performance metrics.
- **Caching Layer** → Improves response time for frequently streamed videos.


```text
├── helm/
│   └── streaming-platform/ 
│       ├── Chart.yml                       #Names, versions, description
│       ├── templates/                       #templated versions of deployments, ingress, etc
│       │   └── app-placeholder.yml
│       └── values.yml                       #Configurations for image repos, tags, resources
├── jenkins/
│   └── JenkinsFile                       #JenkinPipeline
├── k8s/
│   ├── analytics/..                       #Deployment setup with HPA
│   ├── delivery/..                       #Deployment setup with HPA
│   ├── encoding/
│   │   ├── deployment.yml                       #Runs pods
│   │   ├── hpa.yml                       #Horizontal Auto Scaling based on CPU/RAM usuage
│   │   └── service.yml                       #Exposes service inside cluster
│   ├── ingress.yml                       #Configuration for NGINX
│   ├── keda/
│   │   ├── analytics-scaledobject.yml                       #Scales analytics pods based on redis queue triggers
│   │   ├── delivery-scaledobject.yml                       #Scales delivery pods based on load
│   │   ├── encoding-scaledobject.yml                       #Scales encoding/transcoding pods increases in load
│   │   └── redis-auth.yml                       #Config for KEDA to use redis
│   ├── monitoring/
│   │   ├── grafana.yml                       #Config for dashboard monitoring
│   │   └── prometheus.yml                       #Endpoint scraping and sending to grafana
│   ├── namspace.yml                       #Defines namespace
│   └── redis/
│       ├── configmap.yml                       #Redis config
│       ├── deployment.yml                       #Deployment of redis
│       ├── networkpolicy.yml                       #Allows redis to talk to pods
│       ├── pvc.yml                       #Persistant volume claim for redis data
│       ├── secrets.yml                       #Auth creds
│       └── service.yml                       #Exposed redis to cluster
├── ops/
│   ├── ansible/
│   │   ├── group-vars/
│   │   │   └── serviceList.yml                       #List of services for ansible
│   │   ├── inventories/
│   │   │   └── hosts.ini                       #Node list for playbook
│   │   └── playbooks/
│   │       └── updateServices.yml                       #Updates, redeploys and restarts (rolling)
│   ├── kubeconfig
│   └── scripts/
│       ├── deployAll.sh                       #Deploys all services manually
│       ├── deployServices.sh                       #Deploys streaming services 
│       └── readme
├── readme.md
└── services/                       #Microservices
    ├── analytics/..                       #Same as encoding for analytics
    ├── delivery/..                       #Same as encoding for delivery
    └── encoding/
        └── src/
            └── main/
                └── java/
                    └── com/
                        └── streaming/
                            └── encoding/
                                ├── DockerFile                       #Defines container
                                ├── EncodingApplication.java                       #Entry point main code (Springboot)
                                ├── config/
                                │   └── EncodingConfig.java                       #Service configs
                                ├── controller/
                                │   └── EncodingController.java                       #Endpoint defs
                                ├── pom.xml
                                └── service/
                                    └── EncodingService.java                       #Service logic

```
