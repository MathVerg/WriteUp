FROM alpine:latest
EXPOSE 1337

RUN apk add --no-cache socat gcompat

RUN addgroup -S challenge && adduser -S challenge -G challenge -h /challenge

ENV FLAG=RM{Wh3r3_th3r3_1s_sh0ut1ng_th3r3_1s_n0_tru3_knowl3dg3_1B09ED80D21321F2BB6}

WORKDIR /challenge/
COPY ./shouting ./
RUN chown -R root:root . && \
    chmod 755 shouting

USER challenge
CMD /usr/bin/socat TCP-LISTEN:1337,reuseaddr,fork EXEC:/challenge/shouting
