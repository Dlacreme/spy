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
scope: ./src/
once:
  # ONCE commands are executed only once at the very beggining
  - echo "SPY is starting"
always:
  # ALWAYS commands are executed everytime a file is updated
  - crystal run ./src/spy.cr
async:
  # ASYNC commands are executed everytime a file is updated but is non blocking and simply display the output (useful for tests)
  - crystal spec # !ASYNC IS NOT WORKING YET
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
