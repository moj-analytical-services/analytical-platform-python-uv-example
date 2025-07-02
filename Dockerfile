FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.16.0@sha256:96551185eef8ff5f54f82b6a55c5df570a795d155851cde1811f230423efca1b

# https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
ENV UV_COMPILE_BYTECODE=1

COPY src/ .
# COPY moj-analytical-services/octo-sts-1 octo-sts-1

RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
<<EOF
uv sync --frozen --no-dev --no-editable --no-install-project
EOF

ENTRYPOINT ["uv", "run", "main.py"]
