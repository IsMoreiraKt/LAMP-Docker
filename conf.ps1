$CERT_DIR = Join-Path -Path $PWD -ChildPath "mysql\ssl"

function Create-Cert-Dir {
    if (-not (Test-Path -Path $CERT_DIR)) {
        New-Item -ItemType Directory -Force -Path $CERT_DIR
    }
}

function Generate-CA-Cert {
    openssl genrsa 2048 > "$CERT_DIR\ca-key.pem"
    openssl req -new -x509 -nodes -days 365 -key "$CERT_DIR\ca-key.pem" -out "$CERT_DIR\ca.pem" -subj "/CN=MySQL-CA"
}

function Generate-Server-Key-And-Req {
    openssl genrsa 2048 > "$CERT_DIR\server-key.pem"
    openssl req -new -key "$CERT_DIR\server-key.pem" -out "$CERT_DIR\server-req.pem" -subj "/CN=MySQL-Server"
}

function Sign-Server-Cert {
    openssl x509 -req -in "$CERT_DIR\server-req.pem" -days 365 -CA "$CERT_DIR\ca.pem" -CAkey "$CERT_DIR\ca-key.pem" -set_serial 01 -out "$CERT_DIR\server-cert.pem"
}

function Cleanup-Server-Req {
    Remove-Item "$CERT_DIR\server-req.pem"
}

Create-Cert-Dir
Generate-CA-Cert
Generate-Server-Key-And-Req
Sign-Server-Cert
Cleanup-Server-Req
