# syntax=docker/dockerfile:1.4

ARG BASE_IMAGE

FROM ${BASE_IMAGE}

COPY main.py /app/main.py

CMD ["python", "/app/main.py"]
