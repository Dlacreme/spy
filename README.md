# Spy

Hot reload on any application

## Installation

### Direct download
```sh
# Download the binary
$ wget https://github.com/Dlacreme/spy/raw/master/dist/spy && chmod +x spy 

# (optional) Download a default config file (spy.yml). See `usage` for more information
$ wget https://github.com/Dlacreme/spy/raw/master/spy.yml 

# Run
$ ./spy
```

### From source
```sh
$ git clone https://github.com/dlacreme/spy.git && cd spy
$ crystal build ./src/spy.cr --release
$ cp spy && spy.yml /path/to/your/project
$ cd /path/to/your/project
$ ./spy
```

## Usage

Create a `spy.yml` file at the root of your project:

```yml
# spy.yml
target: ./src/
once:
  # commands executed before watching files
  - build.sh
  - start_server.sh
always:
  # commands executed everytime a file is updated
  - build.sh
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
