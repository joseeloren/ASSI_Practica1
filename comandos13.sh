#!/bin/bash
#documento cifrado
openssl enc -e -aes-256-cbc -in texto_legible -out texto_cifrado.aes -k 123456 -a
#clave simetrica cifrada con cable publica receptor
echo '123456' > clave_legible
openssl enc -e -aes-256-cbc -in clave_legible -out clave_cifrada.aes -pass file:./clave_publica_receptor.pem -a
#resumen documento original cifrada con cable privada emisor
openssl dgst -sha256 -sign "clave_privada_jlorenzo.pem" -out texto_legible_firma.sha256 texto_legible
#verificar que resumen ok
openssl dgst -sha256 -verify clave_publica_jlorenzo.pem -signature texto_legible_firma.sha256 texto_legible
#descifrar clave asimetria fichero
openssl enc -d -aes-256-cbc -in clave_cifrada.aes -out clave_legible_receptor -pass file:./clave_publica_receptor.pem -a
#descifrar documento
openssl enc -d -aes-256-cbc -in texto_cifrado.aes -out texto_legible_receptor -pass file:./clave_legible_receptor -a

