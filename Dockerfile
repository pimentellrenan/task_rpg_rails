FROM ruby:3.3.6-slim

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl git libpq-dev libyaml-dev pkg-config postgresql-client && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /rails

COPY Gemfile Gemfile.lock* ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bash", "-lc", "ruby bin/rails db:prepare && (ruby bin/rails tailwindcss:watch & ruby bin/rails server -b 0.0.0.0)"]
