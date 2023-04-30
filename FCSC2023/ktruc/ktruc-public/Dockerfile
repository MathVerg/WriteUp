FROM ubuntu:kinetic
WORKDIR /app/
RUN apt-get update                              && \
    apt-get install -qy --no-install-recommends    \
        socat=1.7.4.1-3ubuntu5                     \
        python3=3.10.6-1                           \
        qemu-system-x86=1:7.0+dfsg-7ubuntu2.2   && \
    apt-get clean                               && \
    rm -rf /var/lib/apt/lists/                  && \
    useradd ctf                                 && \
    chown ctf:ctf /usr/bin/socat                && \
    chmod 500 /usr/bin/socat
COPY --chmod=400 --chown=ctf:ctf src/flag.txt ./
COPY --chmod=400 --chown=ctf:ctf public/initrd ./
COPY --chmod=400 --chown=ctf:ctf public/kinetic-server-cloudimg-amd64-vmlinuz-generic ./
COPY --chmod=400 --chown=ctf:ctf public/proof-of-work.py ./
COPY --chmod=500 --chown=ctf:ctf public/run.sh ./

EXPOSE 4000
USER ctf
CMD ["socat", "tcp-listen:4000,reuseaddr,fork", "exec:'python3 -u proof-of-work.py'"]
