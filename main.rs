use warp::Filter;
use std::env;

#[tokio::main]
async fn main() {
    
    let port = env::var("SERVER_PORT").unwrap_or("80".to_string());

    let hello = warp::path!("hello" / String)
        .map(|name| format!("Hello, {}!", name));

    println!("Server is ready to handle requests at port: {}", port);
    let port: u16 = port.parse().unwrap();
    warp::serve(hello)
        .run(([0, 0, 0, 0], port))
        .await;
}
