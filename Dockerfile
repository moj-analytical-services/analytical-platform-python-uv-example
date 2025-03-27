FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.9.0@sha256:e8d4a3f42941d5e6f85f0e71b6035dddc46ee52e3698e09eb52f4ed439d68d02

# https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
ENV UV_COMPILE_BYTECODE=1

COPY src/ .

RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
<<EOF
uv sync --frozen --no-dev --no-editable --no-install-project 
EOF

ENTRYPOINT ["uv", "run", "main.py"]
