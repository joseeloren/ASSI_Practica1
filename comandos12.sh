#!/bin/bash

#rm clave_p*

#Algoritmos de Resumen
openssl dgst -sha256 texto_legible
openssl dgst -sha384 texto_legible
openssl dgst -sha512 texto_legible

#Modificar fichero texto_legible
cat texto_legible | tr 'E' 'U' > texto_legible_modificado
openssl dgst -sha256 texto_legible_modificado
openssl dgst -sha384 texto_legible_modificado
openssl dgst -sha512 texto_legible_modificado


#Crear clave privada RSA
#openssl genrsa -aes256 -out clave_privada_jlorenzo.pem 2048 
#openssl rsa -in clave_privada_jlorenzo.pem -out clave_publica_jlorenzo.pem -pubout -outform PEM

#PEM To DER y viceversa
#openssl rsa -outform DER -inform PEM -in clave_privada_jlorenzo.pem -out clave_privada_jlorenzo.der
#openssl rsa -outform DER -inform PEM -pubout -in clave_privada_jlorenzo.pem -out clave_publica_jlorenzo.der
#openssl rsa -inform DER -outform PEM -in clave_privada_jlorenzo.der -out clave_privada_jlorenzo2.pem
#openssl rsa -inform DER -outform PEM -pubout -in clave_privada_jlorenzo.der -out clave_publica_jlorenzo2.pem

#Firma y verificacion
openssl dgst -sha256 -sign "clave_privada_jlorenzo.pem" -out texto_legible_firma.sha256 texto_legible 
openssl dgst -sha256 -verify clave_publica_jlorenzo.pem -signature texto_legible_firma.sha256 texto_legible

#Hacer lo mismo para dsa
