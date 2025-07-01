# get python base
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG PIP_ACCESS_TOKEN
ARG PYPI_URL=https://${PIP_ACCESS_TOKEN}@pkgs.dev.azure.com/VanOord-IT/VanOord_Artifacts/_packaging/VanOord_Artifacts/pypi/simple/


# use the same userid in the container as you have outside of the container
# this avoids permission conflicts when mounting volumes 
# as default use 1000/1000 as UID/GID, but they can be changed at build time if required
# Create user and group
RUN groupadd -g $USER_GID me && useradd -ms /bin/bash -u $USER_UID -g $USER_GID me


# Install dependencies
RUN --mount=type=cache,target=/var/cache/apt \
    apt-get update -qq && apt-get upgrade -yq && \
    apt-get install -yqq --no-install-recommends \
    git zsh curl gnupg2 lsof wget iproute2 make

# clean up apt cache
RUN rm -rf /var/lib/apt/lists/*

# Set environment variable
ENV VIRTUAL_ENV=/home/me/.venv
ENV UV_INDEX=${PYPI_URL}
ENV UV_LINK_MODE=copy
ENV UV_COMPILE_BYTECODE=1
ENV UV_PROJECT_ENVIRONMENT=$VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Switch to the non-root user
USER me

# Set working directory
WORKDIR /{{cookiecutter.project_repo}}

# Copy application code with correct ownership
COPY --chown=me:me . /{{cookiecutter.project_repo}}

# Install all dependencies including the project
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev
