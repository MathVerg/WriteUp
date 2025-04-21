FROM ubuntu:24.04
WORKDIR /app/
RUN apt-get update                                 && \
    apt-get install -qy --no-install-recommends       \
        toilet=0.*                                    \
        socat=1.8.*                                && \
    apt-get clean                                  && \
    rm -rf /var/lib/apt/lists/                     && \
    userdel -r ubuntu                              && \
    useradd ctf
COPY --chown=ctf:ctf --chmod=500 ./swift-encryptor ./
COPY --chown=ctf:ctf --chmod=400 ./src/flag.txt ./
EXPOSE 4000
USER ctf
CMD ["socat", "tcp-listen:4000,reuseaddr,fork", "exec:'/usr/bin/stdbuf -o 0 /usr/bin/timeout -k 121 120 /app/swift-encryptor'"]
