# Use official myoung34 GitHub Actions runner as base
ARG RUNNER_VERSION=2.328.0
FROM myoung34/github-runner:${RUNNER_VERSION}

# Install sudo
USER root
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

# Give runner sudo privileges (passwordless)
RUN usermod -aG sudo runner && \
    echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to runner user
USER runner
# WORKDIR /home/runner

# Install Nix (single-user, no daemon, flakes enabled)
RUN curl -L https://nixos.org/nix/install | sh -s -- --no-daemon && \
    mkdir -p /home/runner/.config/nix && \
    echo "experimental-features = nix-command flakes" > /home/runner/.config/nix/nix.conf

# Ensure nix.sh is loaded
RUN echo ". /home/runner/.nix-profile/etc/profile.d/nix.sh" >> /home/runner/.bashrc \
    && echo ". /home/runner/.nix-profile/etc/profile.d/nix.sh" >> /home/runner/.profile

# Install direnv + nix-direnv via Nix
RUN . /home/runner/.nix-profile/etc/profile.d/nix.sh

# Ensure nix profile bin is always in PATH
ENV PATH="/home/runner/.nix-profile/bin:${PATH}"

# RUN . /home/runner/.profile

RUN nix profile install nixpkgs#direnv nixpkgs#nix-direnv

# Back to root so entrypoint.sh works correctly
USER root

# Keep using the base image’s entrypoint
ENTRYPOINT ["/entrypoint.sh"]
CMD ["./bin/Runner.Listener", "run", "--startuptype", "service"]
