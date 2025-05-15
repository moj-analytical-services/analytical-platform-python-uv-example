FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.13.0@sha256:a6dbd8483f4a75b0c328fe16602a8eaceea7c232c4c54349bfc697a2749f3b9a

# https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
ENV UV_COMPILE_BYTECODE=1

COPY src/ .

RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
<<EOF
uv sync --frozen --no-dev --no-editable --no-install-project 
EOF

ENTRYPOINT ["uv", "run", "main.py"]
