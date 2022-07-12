ARG RUST_VERSION
ARG ALPINE_VERSION

FROM rust:${RUST_VERSION}-slim as builder

WORKDIR /tmp/app

COPY Cargo.lock .
COPY Cargo.toml .
COPY main.rs .

# if 'debian:buster-slim'
# RUN cargo build --release

# if 'alpine'
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo build --target x86_64-unknown-linux-musl --release


# FROM debian:buster-slim as runtime
# ARG APPNAME
# COPY --from=builder /tmp/dummy/target/release/${APPNAME} /usr/local/bin/${APPNAME}

FROM alpine:${ALPINE_VERSION} as runtime
ARG APPNAME
COPY --from=builder /tmp/app/target/x86_64-unknown-linux-musl/release/${APPNAME} /usr/bin/${APPNAME}

ENV SERVER_PORT 80

CMD ["simple-rust-web-server"]
