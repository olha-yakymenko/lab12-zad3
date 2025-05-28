# syntax=docker/dockerfile:1.4

# ARG TARGETOS
# ARG BASE_IMAGE

# FROM ${BASE_IMAGE} AS base

# COPY main.py /app/main.py

# CMD ["python", "/app/main.py"]




# syntax=docker/dockerfile:1.4

ARG BASE_IMAGE

FROM ${BASE_IMAGE}

COPY main.py /app/main.py

CMD ["python", "/app/main.py"]
