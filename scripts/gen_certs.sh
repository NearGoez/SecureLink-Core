set -e

#initial config

CA_SUBJ="/C=CL/ST=RM/L=Santiago/O=NearGoez/OU=SecOps/CN=Senior-Root-CA"
SERVER_SUBJ="/C=CL/ST=RM/L=Santiago/O=NearGoez/OU=Agent/CN=android-agent"
CLIENT_SUBJ="/C=CL/ST=RM/L=Santiago/O=NearGoez/OU=Admin/CN=admin-pc"

# 1. Cleaning remaining dirs
rm -rf ../certs
mkdir -p ../certs/ca
mkdir -p ../certs/server
mkdir -p ../certs/client

# 2. Generate CA
echo "Generating Root CA..."
openssl genrsa -aes256 -passout pass:1234 -out ../certs/ca/ca.key 4096
openssl req -new -x509 -days 3650 -key ../certs/ca/ca.key -passin pass:1234 \
    -subj "$CA_SUBJ" -out ../certs/ca/ca.crt

# 3. Generating server identity 
echo "Generating Server Certificate.."
openssl genrsa -out ../certs/server/server.key 2048
openssl req -new -key ../certs/server/server.key -subj "$SERVER_SUBJ" -out ../certs/server/server.csr
openssl x509 -req -in ../certs/server/server.csr -CA ../certs/ca/ca.crt -CAkey ../certs/ca/ca.key \
    -passin pass:1234 -CAcreateserial -out ../certs/server/server.crt -days 365 -sha256

# 4. Generate client identity in the pc
echo "Generating client certificate"
openssl genrsa -out ../certs/client/client.key 2048
openssl req -new -key ../certs/client/client.key -subj "$CLIENT_SUBJ" -out ../certs/client/client.csr
openssl x509 -req -in ../certs/client/client.csr -CA ../certs/ca/ca.crt -CAkey ../certs/ca/ca.key \
    -passin pass:1234 -CAcreateserial -out ../certs/client/client.crt -days 365 -sha256


# 5. securing the files
chmod 400 ../certs/ca/ca.key
chmod 444 ../certs/ca/ca.crt
rm ../certs/*/*.csr

echo "Key generating succesful."

