FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.14.0@sha256:e6b0859e770b45e3ce13656ca39a24cb60db8237bb0638c34c35a26eaf59ee83

# https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
ENV UV_COMPILE_BYTECODE=1

COPY src/ .

RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
<<EOF
uv sync --frozen --no-dev --no-editable --no-install-project 
EOF

ENTRYPOINT ["uv", "run", "main.py"]
