## Simple Rust Web Server

```
$ make

Usage:
  make <target>

Targets:
  run              Run app
  docker-build     Build docker image
  docker-run       Run docker
  docker-stop      Stop docker
```

### \# example
```
$ make run
SERVER_PORT=8080 cargo run --release
    Finished release [optimized] target(s) in 0.07s
     Running `target/release/simple-rust-web-server`
Server is ready to handle requests at port: 8080

$ curl localhost:8080/hello/world
Hello, world!
```