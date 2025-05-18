FROM ubuntu:24.04

RUN apt update -y && apt upgrade -y && apt install -y python3-flask && rm -rf /var/lib/apt/lists/*

RUN useradd pwn

COPY ./app /home/pwn

COPY ./flag.txt /flag.txt


RUN chown -R root:pwn /home/pwn

RUN chmod -R 750 /home/pwn

USER pwn

WORKDIR /home/pwn

EXPOSE 1337

CMD ["/usr/bin/python3", "app.py"]