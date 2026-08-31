# Use an official PyTorch image with CUDA support as base (contains Python, CUDA, PyTorch)
FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

# Install FastAPI and Uvicorn (and any other dependencies your app needs)
RUN pip install --no-cache-dir fastapi uvicorn

# Copy application code
WORKDIR /app
COPY . .

# Expose port 8000 (the port our FastAPI app will run on)
EXPOSE 8000

# Specify the entrypoint to run the app with Uvicorn (listening on all interfaces at port 8000)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]