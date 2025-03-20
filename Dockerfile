FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.8.0@sha256:a7d7872482a845e67fc7f78401a6e4a89d906f07d67aca1f7c636cd3c92ae81a

ENV UV_COMPILE_BYTECODE=1

RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    uv sync \
    uv pip list

# Execute main.py script
# ENTRYPOINT ["python3", "main.py"]
