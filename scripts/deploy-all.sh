#!/bin/bash
echo "Building all services..."
#Encoding
cd services/encoding
mvn clean package 
docker build -t encoding-service:latest .
cd ../..

#Delivery
cd services/delivery
mvn clean package 
docker build -t delivery-service:latest .
cd ../..

#Analytics
cd services/analytics
mvn clean package 
docker build -t analytics-service:latest .
cd ../..

echo "All services built successfully!"