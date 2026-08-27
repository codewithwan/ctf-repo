FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY src/ ./

RUN make clean && make

EXPOSE 32012

CMD ["./napaseke"]
