set shell := ["bash", "-eu", "-o", "pipefail", "-c"]
set dotenv-load := false
host := "127.0.0.1"
port := "4000"

help:
    @just --list

bootstrap:
    @command -v ruby >/dev/null || { echo 'Ruby is required' >&2; exit 1; }
    @command -v bundle >/dev/null || { echo 'Bundler required: gem install bundler' >&2; exit 1; }
    @bundle check >/dev/null 2>&1 || bundle install

install: bootstrap

setup:
    @test -f _config.yml || { echo 'Missing _config.yml' >&2; exit 1; }
    @test -f Gemfile || { echo 'Missing Gemfile' >&2; exit 1; }
    @test -f VERSION || { echo 'Missing VERSION' >&2; exit 1; }

fmt-check:
    @command -v ruby >/dev/null || { echo 'Ruby required' >&2; exit 1; }
    @ruby -e 'require "yaml"; %w[_config.yml _data/navigation.yml update-cli.yaml].each { |f| YAML.parse_file(f); puts "YAML OK: #{f}" }'
    @ruby -e 'v = File.read("VERSION").strip; abort "Invalid SemVer: #{v}" unless v.match?(/\A(?:0|[1-9]\d*)\.(?:0|[1-9]\d*)\.(?:0|[1-9]\d*)\z/); puts "VERSION #{v}"'

lint: fmt-check
    @bundle exec jekyll doctor

test: lint
    @bundle exec jekyll build --strict_front_matter --destination _site

build: test
    @test -f _site/index.html || { echo 'Missing _site/index.html' >&2; exit 1; }

ci: build
    @test -s _site/index.html || { echo 'Empty build artifact' >&2; exit 1; }

precommit: test

run: bootstrap
    bundle exec jekyll serve --host {{host}} --port {{port}} --livereload

serve: run

clean:
    @command -v bundle >/dev/null || { echo 'Bundler required' >&2; exit 1; }
    bundle exec jekyll clean
