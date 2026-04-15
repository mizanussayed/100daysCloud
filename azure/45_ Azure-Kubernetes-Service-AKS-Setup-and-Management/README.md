# Day 45: Azure Kubernetes Service (AKS) Setup and Management

## 🎯 Objective
The Nautilus DevOps team is tasked with preparing an AKS cluster to deploy a Kubernetes-based application. The team has the following requirements:

1. Create an AKS cluster named xfusion-aks.
2. The Kubernetes version must be 1.33.0.
3. The AKS cluster endpoint access must be private.
4. Ensure the cluster is created in the Central US region.
5. Edit the agentpool Node pools (delete all other node pool if exists) and configure the cluster with the following properties:
   - Node size: D2s v3.
   - Minimum node count: 1.
   - Maximum node count: 2.
   - Disable the Container Insights for now and disable all kind of monitoring as well.
The AKS cluster must be configured with high availability and private endpoint access. Verify that the cluster meets the requirements and is ready for workloads.

## Video Walkthrough
[![Azure Kubernetes Service (AKS) Setup and Management](https://img.youtube.com/vi/00h0QGGso1s/0.jpg)](https://youtu.be/AcmfSlDGnvk)