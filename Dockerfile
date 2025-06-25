FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.15.0@sha256:9802aede594062995aca0daeb9c6c159eea742fbc6602233739eccbb14b1ed17

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
