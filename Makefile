OPENAPI_URL ?= https://core-dev.agoraai.tech/openapi.json
OPENAPI_SPEC ?= openapi/agora-public-api.yaml
GENERATOR_VERSION ?= v7.12.0
RESTISH_VERSION ?= 2.1.0
RESTISH ?= tools/restish/restish
RESTISH_CONFIG ?= restish/agora.restish.json

.PHONY: fetch-openapi lint-openapi lint-plugin generate generate-sdks generate-skills test clean-generated install-restish setup-restish restish-help

fetch-openapi:
	./scripts/fetch-openapi.sh "$(OPENAPI_URL)" "$(OPENAPI_SPEC)"

lint-openapi:
	./scripts/lint-openapi.sh "$(OPENAPI_SPEC)"

lint-plugin:
	./scripts/lint-plugin.sh plugins/agora-api

generate: generate-sdks generate-skills

generate-sdks:
	OPENAPI_SPEC="$(OPENAPI_SPEC)" GENERATOR_VERSION="$(GENERATOR_VERSION)" ./scripts/generate-sdks.sh

generate-skills:
	OPENAPI_SPEC="$(OPENAPI_SPEC)" ./scripts/generate-skills.sh

test: lint-openapi lint-plugin
	./scripts/smoke-test.sh

clean-generated:
	rm -rf sdks/python sdks/typescript sdks/java sdks/go
	mkdir -p sdks/python sdks/typescript sdks/java sdks/go

install-restish:
	./scripts/install-restish.sh "$(RESTISH_VERSION)" "$(RESTISH)"

setup-restish:
	./scripts/setup-restish.sh "$(RESTISH_CONFIG)" "$(OPENAPI_SPEC)"

restish-help:
	"$(RESTISH)" --rsh-config "$(RESTISH_CONFIG)" agora --help
