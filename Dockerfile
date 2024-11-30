FROM python:3.9-slim

# Create WorkDir
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copi service
COPY service/ ./service/

# Add User
RUN useradd --uid 100 theia && chown -R theia /app
USER theia

# Runservice
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]