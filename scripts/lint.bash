#!/usr/bin/env bash

# Enable globstar for recursive globbing
shopt -s globstar

shellcheck --shell=bash --external-sources \
	bin/* --source-path=template/lib/ \
	lib/* \
	scripts/*

shfmt --language-dialect bash --diff \
	./**/*
