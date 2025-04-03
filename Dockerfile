FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.10.0@sha256:435e10620395b9b249bd84ae776bc43be17c819a3df1123016b9ea70da05f3d2

# https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
ENV UV_COMPILE_BYTECODE=1

COPY src/ .

RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
<<EOF
uv sync --frozen --no-dev --no-editable --no-install-project 
EOF

ENTRYPOINT ["uv", "run", "main.py"]
