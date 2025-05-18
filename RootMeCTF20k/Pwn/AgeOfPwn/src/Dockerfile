FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y

RUN useradd -m pwn

ADD flag.txt /flag.txt

ADD run.sh /home/pwn/run.sh

RUN chmod 0755 /home/pwn/run.sh

ADD server.bin /home/pwn/server

RUN chmod 0755 /home/pwn/server

EXPOSE 1234

USER pwn

CMD ["/home/pwn/run.sh", "1234"]