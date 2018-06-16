# mdl-api

A very simple [markdownlint](https://github.com/markdownlint/markdownlint) API.

## Usage

```
bundle install
bundle exec rackup -p 9292 config.ru
curl -X POST http://localhost:9292 --data 'Hello World'
```

This will return an array of rules that are being broken by the submitted text.

```json
["First line in file should be a top level header"]
```
