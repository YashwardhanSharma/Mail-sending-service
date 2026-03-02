FROM ruby:3.3.5

WORKDIR /app

# Install correct bundler version FIRST
RUN gem install bundler:4.0.4

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

ENV RAILS_ENV=production
ENV PORT=8080

EXPOSE 8080

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]