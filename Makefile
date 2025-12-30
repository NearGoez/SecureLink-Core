PYTHON = python3.11
PROTOC = $(PYTHON) -m grpc_tools.protoc
PROTO_DIR = proto
CLIENT_DIR = client


.PHONY: all certs proto clean

all: certs proto

proto: 
	@echo "Generating python stubs from $(PROTO_DIR)/adms.proto"
	mkdir -p $(CLIENT_DIR)
		$(PROTOC) -I $(PROTO_DIR) \
			--python_out=$(CLIENT_DIR) \
			--grpc_python_out=$(CLIENT_DIR) \
			$(PROTO_DIR)/adms.proto
clean:
	rm -rf $(CLIENT_DIR)/*_pb2*.py

