# LXD gem for mruby

This repository contains LXD gem for mruby.

## Getting started

Add this line on mruby `build_config.rb` before compilation.

```
...
conf.gem github: 'pathfinder-cm/mruby-lxd'
...
```

Then you can run `./minirake` to start the compilation process. The resulting binaries can be used to run mruby scripts to communicate with LXD.

For more info please consult [this][mruby-compile-guide] guide to compile mruby.

## Development Setup

Ensure that you are using Ubuntu or Ubuntu-derived OS with version `16.04` or greater with LXD installed, preferrably as snap package. You can follow this steps to ensure that LXD snap is installed.

> Note: This will remove existing LXD apt package and all LXCs on it.

```
sudo apt-get purge lxd* -y
sudo apt install zfsutils-linux -y
sudo snap install lxd --channel=3.0/stable
sudo lxd init
```

### Running tests

Compile mruby with these 2 gems enabled.

```
...
conf.gem github: 'iij/mruby-require'
conf.gem github: 'iij/mruby-mtest'
...
```

Run `mruby test/**`

> Note: May need to run the command using `sudo` if the user is not in `lxd` group.

## Getting Help

If you have any questions or feedback regarding mruby-lxd:

- [File an issue](https://github.com/pathfinder-cm/mruby-lxd/issues/new) for bugs, issues and feature suggestions.

Your feedback is always welcome.

## Further Reading

- [mruby documentation][mruby-doc]
- [Guide to compile mruby][mruby-compile-guide]
- [mrbgems documentation][mrbgems-doc]
- [LXD REST API documentation][lxd-rest-api-doc]

[mruby-doc]: https://github.com/mruby/mruby/tree/master/doc
[mruby-compile-guide]: https://github.com/mruby/mruby/blob/master/doc/guides/compile.md
[mrbgems-doc]: https://github.com/mruby/mruby/blob/master/doc/guides/mrbgems.md
[lxd-rest-api-doc]: https://github.com/lxc/lxd/blob/master/doc/rest-api.md

## License

MIT License, see [LICENSE](LICENSE).
