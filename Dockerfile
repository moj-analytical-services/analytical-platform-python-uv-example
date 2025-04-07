FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.10.1@sha256:24f55afb965362ca37a5dc23f27fef8c46925061f1665abd507abafb6fd2ab78

# https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
ENV UV_COMPILE_BYTECODE=1

COPY src/ .

RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
<<EOF
uv sync --frozen --no-dev --no-editable --no-install-project 
EOF

ENTRYPOINT ["uv", "run", "main.py"]
