#!/bin/bash
openssl aes-256-cbc -k ${ENCRYPT_PASS} -in travis/scripts/cert/travisPOC.mobileprovision.enc -out travis/scripts/cert/travisPOC.mobileprovision -d -a
openssl aes-256-cbc -k ${ENCRYPT_PASS} -in travis/scripts/cert/ios_distribution.cer.enc -out travis/scripts/cert/ios_distribution.cer -d -a
openssl aes-256-cbc -k ${ENCRYPT_PASS} -in travis/scripts/cert/Certificates.p12.enc -out travis/scripts/cert/Certificates.p12 -d -a
