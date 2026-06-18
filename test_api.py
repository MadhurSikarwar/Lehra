import requests
import time

url = "http://localhost:3000/api/separate"
file_path = "assets/tanpura_06_01.wav"

with open(file_path, "rb") as f:
    files = {"file": f}
    resp = requests.post(url, files=files)
    
if resp.status_code != 200:
    print("Upload failed:", resp.text)
    exit(1)

job_id = resp.json()["job_id"]
print("Job ID:", job_id)

while True:
    status_resp = requests.get(f"http://localhost:3000/api/job_status/{job_id}")
    data = status_resp.json()
    print("Status:", data)
    if data["status"] in ["completed", "error"]:
        break
    time.sleep(2)
