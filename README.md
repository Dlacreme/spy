# Spy

Hot reload on any application

## Installation

From source
```sh
$ git clone https://github.com/dlacreme/spy.git && cd spy
$ crystal build ./src/spy.cr --release
```

## Usage

Create a `spy.yml` file at the root of your project:

```yml
# spy.yml
scope: *
once:
  - echo "SPY is starting"
always:
  - crystal run ./src/spy.cr
async:
  - crystal spec
```
Then simply run `spy`
```sh
$ spy
```


## Contributing

1. Fork it (<https://github.com/dlacreme/spy/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Mathieu Delacroix](https://github.com/dlacreme) - creator and maintainer
