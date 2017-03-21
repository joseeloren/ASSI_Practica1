#!/bin/bash
#Preparamos el entorno
rm *cifrado* 2> /dev/null

echo Texto legible:
cat texto_legible
echo 

#Cifrar con CINCO algoritmos simétricos
echo 'Cifrado con AES:'
openssl enc -e -aes-256-cbc -in texto_legible -out texto_cifrado.aes -k 123456 -salt -a -p
echo Texto cifrado AES:
cat texto_cifrado.aes
echo
echo
echo 'Cifrado con TDES:'
openssl enc -e -des-ede3-cbc -in texto_legible -out texto_cifrado.tdes -k 12345 -salt -a -p
echo Texto cifrado TDES:
cat texto_cifrado.tdes
echo
echo 'Cifrado con CAMELLIA:'
openssl enc -e -camellia-128-cbc -in texto_legible -out texto_cifrado.camellia -k 12345 -salt -a -p
echo Texto cifrado CAMELLIA:
cat texto_cifrado.camellia
echo
echo 'Cifrado con RC2:'
openssl enc -e -rc2-cbc -in texto_legible -out texto_cifrado.rc2 -k 12345 -salt -a -p
echo Texto cifrado RC2:
cat texto_cifrado.rc2
echo 
echo 'Cifrado con RC4 (cifrador en flujo)'
openssl enc -e -rc4 -in texto_legible -out texto_cifrado.rc4 -k 12345 -salt -p
echo Texto cifrado RC4:
cat texto_cifrado.rc4
echo

#Descifrar con los CINCO algoritmos simétricos
echo 'Descifrado con AES:'
openssl enc -d -aes-256-cbc -in texto_cifrado.aes -out texto_descifrado.aes -k 12345 -a
echo 'Descifrado con TDES:'
openssl enc -d -des-ede3-cbc -in texto_cifrado.tdes -out texto_descifrado.tdes -k 12345 -a
echo 'Descifrado con CAMELLIA:'
openssl enc -d -camellia-128-cbc -in texto_cifrado.camellia -out texto_descifrado.camellia -k 12345 -a
echo 'Descifrado con RC2:'
openssl enc -d -rc2-cbc -in texto_cifrado.rc2 -out texto_descifrado.rc2 -k 12345 -a 
echo 'Descifrado con RC4 (cifrador en flujo):'
openssl enc -d -rc4 -in texto_cifrado.rc4 -out texto_descifrado.rc4 -k 12345 

#Comprobamos la igualdad de los ficheros
echo 'Comprobración de integridad AES':
diff texto_legible texto_descifrado.aes
echo 'Comprobración de integridad TDES':
diff texto_legible texto_descifrado.tdes
echo 'Comprobración de integridad CAMELLIA':
diff texto_legible texto_descifrado.camellia
echo 'Comprobración de integridad RC2':
diff texto_legible texto_descifrado.rc2
echo 'Comprobración de integridad RC4':
diff texto_legible texto_descifrado.rc4

#Explicar gestion contraseñas: prueba de sal
openssl enc -e -aes-256-cbc -in texto_legible -out texto_cifrado_con_sal.aes -k 123456 -p > salida_cifrado.txt
cat salida_cifrado.txt
iv=$(cat salida_cifrado.txt | cut -d= -f2 | tail -1)
key=$(cat salida_cifrado.txt | cut -d= -f2 | head -2 | tail -1)
dd if="texto_cifrado_con_sal.aes" of="texto_cifrado_sin_sal.aes" bs=1 skip=16
openssl enc -d -aes-256-cbc -in texto_cifrado_sin_sal.aes -out texto_legible_sal.aes -K $key -iv $iv
cat texto_legible_sal.aes
