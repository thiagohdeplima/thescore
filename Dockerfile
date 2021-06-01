FROM elixir:1.12-alpine AS compiler

ARG MIX_ENV=prod
ENV MIX_ENV=${MIX_ENV}

WORKDIR /srv/app

COPY . .

RUN apk add -Uv \
    nodejs \
    npm \
    inotify-tools

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix deps.get \
    && mix deps.compile \
    && mix compile
