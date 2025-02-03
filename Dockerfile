FROM python:3.12-slim

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_VERSION=1.8.3

RUN apt-get update \
    && apt-get -y install --no-install-recommends curl \
    gcc \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir poetry==$POETRY_VERSION

WORKDIR /usr/src/app

COPY poetry.lock pyproject.toml ./
RUN poetry install --no-dev

COPY fastapi_vanilla/ ./fastapi_vanilla/
CMD ["uvicorn", "fastapi_vanilla.main:app", "--host", "0.0.0.0", "--port", "8000"]
