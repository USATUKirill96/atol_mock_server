FROM ubuntu:20.04

ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive


RUN apt update && apt install -y wget gnupg2

RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb \
    && dpkg -i erlang-solutions_2.0_all.deb \
    && apt update \
    && apt install -y esl-erlang


RUN mkdir /app

COPY ./_build/prod/ ./app

WORKDIR /app/

CMD ["/app/rel/atol_server/bin/atol_server", "start"]
