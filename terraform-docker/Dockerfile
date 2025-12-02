FROM python:3.9-slim
WORKDIR /app
COPY demo-api.py /app/
RUN pip install flask psycopg2-binary
ENV USER ubuntu
ENV PASS DEMO1
CMD ["python", "demo-api.py"]
