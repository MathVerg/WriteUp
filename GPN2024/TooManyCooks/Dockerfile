# docker build -t too-many-cooks . && docker run -p 1337:1337 -t too-many-cooks
FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install socat -y
COPY too_many_cooks too_many_cooks

ARG FLAG=GPNCTF{fake_flag}
RUN echo "$FLAG" > /flag

EXPOSE 1337

CMD ["socat", "-v", "tcp-listen:1337,reuseaddr,fork", "EXEC:'./too_many_cooks',stderr"]
