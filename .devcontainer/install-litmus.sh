#!/bin/bash

# Create a Kind cluster
echo "Creating a Kind cluster..."
kind create cluster --name litmus-cluster

# Add LitmusChaos Helm repo
echo "Adding LitmusChaos Helm repository..."
helm repo add litmuschaos https://litmuschaos.github.io/litmus-helm/
helm repo update

# Install LitmusChaos
echo "Installing LitmusChaos..."
kubectl create namespace litmus
helm install litmus litmuschaos/litmus --namespace litmus

# Wait for LitmusChaos components to start
echo "Waiting for LitmusChaos components to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment --all -n litmus

# Verify the installation
echo "LitmusChaos installed successfully!"
kubectl get pods -n litmus
