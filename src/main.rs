use actix_web::{web, App, HttpResponse, HttpServer, Responder};

async fn check_health() -> impl Responder {
    HttpResponse::Ok()
}

#[tokio::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().route("/check_health", web::get().to(check_health)))
        .bind("127.0.0.1:8000")?
        .run()
        .await
}
