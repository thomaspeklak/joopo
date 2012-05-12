# Joopo

A universal proxy for external apis.

This gem opens a server via Sinatra that can be used to proxy external apis. This is usefull for JavaScript development when you need to connect to a server that is not on your development domain. Additionally you can serve your static files and stub apis with fake responses. See example below.

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

    public: test/public
    apis:
      testapi: http://localhost:9000/test/
      fakeapi: 
        content_type: json
        content:  |
          {
            "test": "Hello World"
          }

With this configuration you can make request to `http://localhost:4567/testapi/whatever/you?like` that are proxied to `http://localhost:9000/test/whatever/you?like`. Your static files in `test/public` are served from this proxy, too. E.g. if you have a file `styles.css` in the directory `test/public/styles`, you can access it via `http://localhost:4567/styles/styles.css`.

Because of the _fakeapi_ entry all requests to `http://localhost:4567/fakeapi/` and its subdirectoies will return a json with content `{"test": "Hello World"}`.

## Usage

Run the proxy with `joopo config.yaml`. Now you are able to make request.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
