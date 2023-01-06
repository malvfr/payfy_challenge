
FROM elixir:1.14.0-alpine

WORKDIR /app

RUN mix local.hex --force && \
  mix local.rebar --force

COPY . .


RUN mix do deps.get, deps.compile

EXPOSE 4000