FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.12.0@sha256:f4e6b42430a08e3eeef7ae3b3429745f68827cff0c36b2e67e9b4e683696a9b7

# https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
ENV UV_COMPILE_BYTECODE=1

COPY src/ .

RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
<<EOF
uv sync --frozen --no-dev --no-editable --no-install-project 
EOF

ENTRYPOINT ["uv", "run", "main.py"]
