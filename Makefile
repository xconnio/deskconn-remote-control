export CGO_ENABLED := 1

ifdef XCONN_SDK_DIR
export PKG_CONFIG_PATH := $(abspath $(XCONN_SDK_DIR))/lib/pkgconfig$(if $(PKG_CONFIG_PATH),:$(PKG_CONFIG_PATH))
endif

.PHONY: native-check native-sdk
native-check:
	@pkg-config --exists xconn || (echo "Run make native-sdk once"; exit 1)

native-sdk:
	@set -e; script=$$(mktemp); \
	trap 'rm -f "$$script"' EXIT; \
	curl -fLsS https://raw.githubusercontent.com/xconnio/xconn/v0.6.4/scripts/install-xconn-sdk.sh -o "$$script"; \
	sh "$$script"

test: native-check
	go test -count=1 ./... -v

lint:
	golangci-lint run

build: native-check
	go build -o bin/remotecontrol-app ./cmd/remotecontrol-app

run: native-check
	go run ./cmd/remotecontrol-app
