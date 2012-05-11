# Joopo

A universal proxy for external apis.

This gem opens a server via Sinatra that can be used to proxy external apis. This is usefull for JavaScript development when you need to connect to a server that is not on your development domain.

## Installation

    gem install joopo

And then execute:

    $ joopo config.yaml

## Proxy configuration

The configuration YAML can have the following entries:

- port: the port for Sinatra, defaults to `4567`
- public_folder: the public folder that servers your files, defaults to `public`
- apis: a list of key values of external apis that should be proxied

###Sample

  port: 4567
  public: test/public
  apis:
    testapi: http://localhost:9000/test/

With this configuration you can make request to `http://localhost:4567/testapi/whatever/you?like` that are proxied to `http://localhost:9000/test/whatever/you?like`.

## Usage

Run the proxy with `joopo config.yaml`. Now you are able to make request.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
