
# docker-electrumx

> Run an Electrum server with one command

An easily configurable Docker image for running an Electrum server.

## Build

```
docker build -t coindroid42/electrumx:scribe . \
  --build-arg HASH_MODULE=git+https://github.com/wakiyamap/lyra2re-hash-python.git
```

## Usage

```
docker run \
  --env DAEMON_BIN_URL=https://github.com/scribenetwork/scribe/releases/download/v0.3/scribe-ubuntu-16.04-x64.tar.gz \
  -v /opt/scribe/electrum:/data \
  -p 33001:33001 \
  coindroid42/electrumx:scribe
```

If there's an SSL certificate/key (`electrumx.crt`/`electrumx.key`) in the `/data` volume it'll be used. If not, one will be generated for you.

You can view all ElectrumX environment variables here: https://github.com/kyuupichan/electrumx/blob/master/docs/environment.rst

### TCP Port

By default only the SSL port is exposed. You can expose the unencrypted TCP port with `-p 50001:50001`, although this is strongly discouraged.


### RPC Port

To access RPC from your host machine, you'll also need to expose port 34001. You probably only want this available to localhost: `-p 127.0.0.1:34001:34001`.

If you're only accessing RPC from within the container, there's no need to expose the RPC port.


## License

MIT © Coindroid.org
