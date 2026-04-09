# Day 41: Working with Azure Table Storage

## 🎯 Objective
The Nautilus DevOps team is developing a simple 'To-Do' application using Azure Table Storage to store and manage tasks efficiently. The team needs to create an Azure Table to hold tasks, each identified by a unique taskId. Each task will have a description and a status, which indicates the progress of the task (e.g., 'completed' or 'in-progress').

Your task is to:

1. Create an Azure Storage Account named nautilustablest29015 with a Table Storage table called tasks.
2. Insert the following tasks into the table:
   - Task 1: PartitionKey: 'tasks', RowKey: '1', description: 'Learn Table Storage', status: 'completed'
   - Task 2: PartitionKey: 'tasks', RowKey: '2', description: 'Build To-Do App', status: 'in-progress'
3. Verify that Task 1 has a status of 'completed' and Task 2 has a status of 'in-progress'.

Note: Use the Azure CLI to insert these tasks into the table.

## cli commands to insert tasks:
```bash
az storage entity insert --account-name nautilustablest29015 --table-name tasks --entity PartitionKey=tasks RowKey=1 description='Learn Table Storage' status='completed'
az storage entity insert --account-name nautilustablest29015 --table-name tasks --entity PartitionKey=tasks RowKey=2 description='Build To-Do App' status='in-progress'
```

## Video Demonstration
[![Working with Azure Table Storage](https://img.youtube.com/vi/00h0QGGso1s/0.jpg)](https://www.youtube.com/watch?v=mCJ7U1rDzV4)