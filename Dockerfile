FROM alpine:3.4
RUN echo "hello, simple" && \
    echo "hello, sinple0" > hello.txt && \
    echo "hello, sinple1" >> hello.txt && \
    echo "hello, sinple2" >> hello.txt && \
    echo "hello, sinple3" >> hello.txt && \
    echo "hello, sinple4" >> hello.txt && \
    echo "hello, sinple5" >> hello.txt
