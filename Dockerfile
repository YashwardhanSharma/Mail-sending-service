FROM ruby:3.3.5

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV RAILS_ENV=production
ENV PORT=8080

RUN bundle exec rails assets:precompile

EXPOSE 8080

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]