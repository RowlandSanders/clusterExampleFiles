#!/bin/bash

#Create namespace
kubectl apply -f k8s/namespace.yaml

#Deploy Redis
kubectl apply -f k8s/redis/
kubectl wait --for=condition=ready pod -l app=redis -n streaming-platform --timeout=120s

#Deploy services
kubectl apply -f k8s/encoding/
kubectl apply -f k8s/delivery/
kubectl apply -f k8s/analytics/
#Deploy monitoring
kubectl apply -f k8s/monitoring/
#Deploy ingress
kubectl apply -f k8s/ingress.yaml
#Deploy Services
kubectl wait --for=condition=ready pod -l app=encoding-service -n streaming-platform --timeout=300s
kubectl wait --for=condition=ready pod -l app=delivery-service -n streaming-platform --timeout=300s
kubectl wait --for=condition=ready pod -l app=analytics-service -n streaming-platform --timeout=300s

echo "Deployment complete!"
echo "Check status:"
echo "  kubectl get pods -n streaming-platform"
echo "  kubectl get hpa -n streaming-platform"