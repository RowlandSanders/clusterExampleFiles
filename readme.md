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