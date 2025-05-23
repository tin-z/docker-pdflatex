FROM debian:bookworm
LABEL maintainer="Julian Didier (theredfish)" \
      description="A docker image based on Debian that provides pdflatex and common packages" \
      repo="https://github.com/theredfish/docker-pdflatex"

# Latex packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends texlive-latex-recommended texlive-fonts-recommended && \
    apt-get install -y --no-install-recommends texlive-latex-extra texlive-fonts-extra texlive-lang-all && \
    rm -rf /var/lib/apt/lists/*

# Add user with UID:GID 1000:1000
RUN groupadd -g 1000 appuser && \
    useradd -m -u 1000 -g 1000 -s /bin/bash appuser

# Create a folder for the user
RUN mkdir -p /home/appuser/workdir && \
    chown -R appuser:appuser /home/appuser/workdir

# Set the working directory to the user's folder
WORKDIR /home/appuser/workdir

# Switch to the created user
USER appuser

# Default command
ENTRYPOINT ["pdflatex"]
