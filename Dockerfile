FROM ubuntu:20.04 as builder

ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive


RUN apt update && apt install -y wget gnupg2

RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb \
    && dpkg -i erlang-solutions_2.0_all.deb \
    && apt update \
    && apt install -y esl-erlang elixir nodejs npm

WORKDIR /build/
COPY . .

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --only prod
RUN mix deps.compile
RUN npm install --prefix ./apps/api/assets
RUN npm run deploy --prefix ./apps/api/assets
RUN mix setup
RUN MIX_ENV=prod mix release atol_server --overwrite

CMD ["/build/_build/prod/rel/atol_server/bin/atol_server", "start"]
