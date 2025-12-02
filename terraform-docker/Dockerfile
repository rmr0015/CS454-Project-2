FROM python:3.9-slim
WORKDIR /app
COPY demo-api.py /app/
RUN pip install flask psycopg2-binary
CMD ["python", "demo-api.py"]
