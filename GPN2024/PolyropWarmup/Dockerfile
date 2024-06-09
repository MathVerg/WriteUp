# docker build -t polyrop-warmup . && docker run -p 14140:14140 polyrop-warmup
# provides qemu-9 => pie and stack is (more) random
FROM archlinux/archlinux:base-20240520.0.237425
# provides qemu-8 => pie and stack is (more?) deterministic
# FROM archlinux/archlinux:base-20240422.0.230757
RUN pacman -Syu --noconfirm && pacman -S socat qemu-user python3 --noconfirm
WORKDIR /app
COPY composer-riscv64 /app/composer-riscv64
COPY composer-aarch64 /app/composer-aarch64
COPY composer-s390x /app/composer-s390x
COPY composer-arm /app/composer-arm
COPY composer-x86_64 /app/composer-x86_64
COPY socat.sh /app/socat.sh

ARG FLAG=GPNCTF{fake_flag}
RUN echo "$FLAG" > /app/flag.txt
COPY composer.py /app/composer.py  
RUN chmod 0400 /app/flag.txt

WORKDIR /app
EXPOSE 14140
CMD /app/socat.sh
