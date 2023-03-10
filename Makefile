#======================================#
# GNU Make Options                     #
#======================================#

MAKEFLAGS += --warn-undefined-variables --no-builtin-rules
SHELL := bash
.SHELLFLAGS := -euo pipefail -c

.DELETE_ON_ERROR:
ONESHELL:


#======================================#
# Testing Across Ruby Versions         #
#======================================#

SUPPORTED_RUBY_VERSIONS := 2.7.7  3.0.5  3.1.3  3.2.0
DOCKER_TAG_PREFIX := uuidx-lib:ruby-

test-all: $(foreach version,$(SUPPORTED_RUBY_VERSIONS),test-$(version))
	@echo
	@echo All tests have passed for all Ruby versions.

test-%:
	@echo
	@echo "Testing debian based Ruby $*..."
	@docker build --build-arg "RUBY_VERSION=$*" -t "$(DOCKER_TAG_PREFIX)$*" .
	@docker run --rm -t -v $(PWD):/proj -w /proj $(DOCKER_TAG_PREFIX)$*
	@echo
	@echo "Testing alpine based Ruby $*..."
	@docker build --build-arg "RUBY_VERSION=$*" -t "$(DOCKER_TAG_PREFIX)$*-alpine" -f Dockerfile.alpine .
	@docker run --rm -t -v $(PWD):/proj -w /proj $(DOCKER_TAG_PREFIX)$*-alpine


#======================================#
# Testing RBS Types                    #
#======================================#

rbs:
	@echo Running tests with type checks...
	@RUBYOPT='-rrbs/test/setup' RBS_TEST_LOGLEVEL=error RBS_TEST_RAISE=true \
		RBS_TEST_OPT='-Isig' RBS_TEST_TARGET='Uuidx,Uuidx::*' \
		bundle exec rake test
