FROM ruby:3.3

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \
      cmake \
      git \
      tzdata \
      libpq-dev \
      ruby-dev \
      curl \
      libvips42 \
      postgresql-client \
      iproute2 \
      gnupg

# Install Node.js (v20)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Enable Yarn via Corepack (modern way)
RUN corepack enable

# Clean up apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# App setup
RUN mkdir /app
WORKDIR /app

# Bundler
RUN gem install bundler -v 2.1.4

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["bash"]