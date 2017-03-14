#!/bin/bash
#Preparamos el entorno
rm *cifrado* 2> /dev/null
rm *descifrado* 2> /dev/null

#Cifrar con CINCO algoritmos simétricos
echo AES
openssl enc -e -aes-256-cbc -in texto_legible -out texto_cifrado.aes -k 12345 -salt -a -p 
echo TDES
openssl enc -e -des-ede3-cbc -in texto_legible -out texto_cifrado.tdes -k 12345 -salt -a -p 
echo IDEA
openssl enc -e -idea-cbc -in texto_legible -out texto_cifrado.idea -k 12345 -salt -a -p 
echo RC2
openssl enc -e -rc2-cbc -in texto_legible -out texto_cifrado.rc2 -k 12345 -salt -a -p 
echo 'RC4 (cifrador en flujo)'
openssl enc -e -rc4 -in texto_legible -out texto_cifrado.rc4 -k 12345 -salt -a -p 


#Descifrar con los CINCO algoritmos simétricos
#AES
openssl enc -d -aes-256-cbc -in texto_cifrado.aes -out texto_descifrado.aes -k 12345
#TDES
openssl enc -d -des-ede3-cbc -in texto_cifrado.tdes -out texto_descifrado.tdes -k 12345
#IDEA
openssl enc -d -idea-cbc -in texto_cifrado.idea -out texto_descifrado.idea -k 12345
#RC2
openssl enc -d -rc2-cbc -in texto_cifrado.rc2 -out texto_descifrado.rc2 -k 12345
#RC4 (cifrador en flujo)
openssl enc -d -rc4 -in texto_cifrado.rc4 -out texto_descifrado.rc4 -k 12345

#Comprobamos la igualdad de los ficheros
diff texto_legible texto_descifrado.aes
diff texto_legible texto_descifrado.tdes
diff texto_legible texto_descifrado.idea
diff texto_legible texto_descifrado.rc2
diff texto_legible texto_descifrado.rc4