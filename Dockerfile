# Use an official PyTorch image with CUDA support as base (contains Python, CUDA, PyTorch)
FROM pytorch/pytorch:2.13.0-cuda13.2-cudnn9-runtime

# Copy application code
WORKDIR /app
COPY . .

# Install Poetry using the recommended installer
RUN curl -sSL https://install.python-poetry.org | python3.12 -

# Add Poetry to the PATH so it's available globally
ENV PATH="${PATH}:/root/.local/bin"

# Install the dependencies with Poetry
RUN poetry install --no-root --no-interaction --only main

# Expose port 8000 (the port our FastAPI app will run on)
EXPOSE 8000

# Specify the entrypoint to run the app with Uvicorn (listening on all interfaces at port 8000)

ENTRYPOINT ["poetry"]
CMD ["run", "python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]