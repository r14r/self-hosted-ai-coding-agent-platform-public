set dotenv-load := false
host := "127.0.0.1"
port := "4000"

help:
    @just --list

install:
    bundle install

build:
    bundle exec jekyll build

run:
    bundle exec jekyll serve --host {{host}} --port {{port}} --livereload

serve: run

clean:
    bundle exec jekyll clean
