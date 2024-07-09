FROM cloudron/base:4.2.0@sha256:46da2fffb36353ef714f97ae8e962bd2c212ca091108d768ba473078319a47f4 AS build
WORKDIR /usr/src/app/

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | /bin/bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

COPY . .
RUN cargo build --release

FROM scratch AS binaries
COPY --from=build /usr/src/app/target/release/chief chief
