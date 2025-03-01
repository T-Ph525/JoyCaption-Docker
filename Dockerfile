# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables
ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app
# Copy files from local machine to the working directory in the container
COPY . /app/

# Install model-specific requirements
RUN pip install -r /app/requirements.txt

# Expose the port VLLM will run on
EXPOSE 5000

# Run the model using vllm serve with max-model-len and prefix-caching options
CMD ["vllm", "serve", "fancyfeast/llama-joycaption-alpha-two-hf-llava", "--max-model-len", "4096", "--enable-prefix-caching"]
