FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.11.0@sha256:eb98063dd0a2703bbb71ca3507da48a5142de7c10f0cc5c458c51eec5e2fdde8

# https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
ENV UV_COMPILE_BYTECODE=1

COPY src/ .

RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
<<EOF
uv sync --frozen --no-dev --no-editable --no-install-project 
EOF

ENTRYPOINT ["uv", "run", "main.py"]
