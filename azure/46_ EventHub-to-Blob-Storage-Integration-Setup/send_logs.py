import os
from azure.storage.blob import BlobServiceClient
from azure.eventhub import EventHubProducerClient, EventData

# Event Hub Configuration
eventhub_conn_str = "<Event Hub Connection String>"
eventhub_name = "devops-hub"
producer = EventHubProducerClient.from_connection_string(eventhub_conn_str, eventhub_name=eventhub_name)

# Blob Storage Configuration
blob_conn_str = "<Blob Storage Connection String>"
blob_service_client = BlobServiceClient.from_connection_string(blob_conn_str)
blob_client = blob_service_client.get_blob_client(container="devops-backup-14959", blob="logs.txt")

# Generate and Send Logs
log_data = "Log entry from VM\n"

# Send to Event Hub
event_data_batch = producer.create_batch()
event_data_batch.add(EventData(log_data))
producer.send_batch(event_data_batch)

# Backup to Blob Storage
blob_client.upload_blob(log_data, blob_type="AppendBlob", overwrite=True)

print("Log sent to Event Hub and backed up to Blob Storage.")