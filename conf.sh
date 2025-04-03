#!/bin/sh

CERT_DIR="./mysql/ssl"

function create_cert_dir() {
    mkdir -p "$CERT_DIR"
}

function generate_ca_cert() {
    openssl genrsa 2048 > "$CERT_DIR/ca-key.pem"
    openssl req -new -x509 -nodes -days 365 -key "$CERT_DIR/ca-key.pem" \
        -out "$CERT_DIR/ca.pem" \
        -subj "/CN=MySQL-CA"
}

function generate_server_key_and_req() {
    openssl genrsa 2048 > "$CERT_DIR/server-key.pem"
    openssl req -new -key "$CERT_DIR/server-key.pem" \
        -out "$CERT_DIR/server-req.pem" \
        -subj "/CN=MySQL-Server"
}

function sign_server_cert() {
    openssl x509 -req -in "$CERT_DIR/server-req.pem" \
        -days 365 -CA "$CERT_DIR/ca.pem" \
        -CAkey "$CERT_DIR/ca-key.pem" \
        -set_serial 01 \
        -out "$CERT_DIR/server-cert.pem"
}

function cleanup_server_req() {
    rm "$CERT_DIR/server-req.pem"
}

create_cert_dir
generate_ca_cert
generate_server_key_and_req
sign_server_cert
cleanup_server_req
