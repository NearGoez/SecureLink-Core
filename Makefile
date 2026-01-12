VENV = .venv
PYTHON = $(VENV)/bin/python
PIP = $(VENV)/bin/pip
PROTOC = $(PYTHON) -m grpc_tools.protoc

PROTO_DIR = proto
CLIENT_DIR = client

.PHONY: all proto clean setup

all: setup proto

setup: $(VENV)/bin/activate

$(VENV)/bin/activate: requirements.txt
	python3.11 -m venv $(VENV)
	$(PIP) install -r requirements.txt
	touch $(VENV)/bin/activate

proto: setup
	@echo "Generating python stubs from $(PROTO_DIR)/adms.proto"
	mkdir -p $(CLIENT_DIR)
	$(PROTOC) -I $(PROTO_DIR) \
		--python_out=$(CLIENT_DIR) \
		--grpc_python_out=$(CLIENT_DIR) \
		$(PROTO_DIR)/adms.proto

clean:
	rm -rf $(CLIENT_DIR)/*_pb2*.py
	rm -rf $(VENV)
