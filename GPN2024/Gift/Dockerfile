# docker build -t gift . && docker run -p 1337:1337 -t gift
FROM debian:bookworm

RUN apt-get update && apt-get install -y --no-install-recommends socat make gcc \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY gift.s Makefile /app/
RUN make
ARG FLAG=GPNCTF{fake_flag}
RUN echo "$FLAG" > flag.txt

EXPOSE 1337

ENTRYPOINT [ "socat", "-v", "tcp-l:1337,reuseaddr,fork", "EXEC:./gift,stderr" ]
