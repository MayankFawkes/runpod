# app/main.py
from fastapi import FastAPI
from pydantic import BaseModel
import torch

class InputData(BaseModel):
    values: list[float]

app = FastAPI()

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = torch.nn.Linear(10, 1).to(device)
model.eval()


@app.get("/ping")
async def ping():
    return {"status": "ok"}
	
@app.post("/predict")
async def predict(data: InputData):
    x = torch.tensor(data.values, dtype=torch.float32).to(device)
    x = x.view(1, -1)
    with torch.no_grad():
        output = model(x)
    result = output.cpu().item()
    return {"result": result}

@app.get("/gpu-check")
def gpu_check():
    return {
        "gpu_available": torch.cuda.is_available(),
        "device_name": torch.cuda.get_device_name(0) if torch.cuda.is_available() else "CPU",
    }