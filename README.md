# LXD gem for mruby

This repository contains LXD gem for mruby.

## Getting started

Add this line on mruby `build_config.rb` before compilation.

```
...
conf.gem github: 'pathfinder-cm/mruby-lxd'
...
```

Then you can run `./minirake` to start the compilation process.

For more info please consult [this][mruby-doc] guide to compile mruby.

## Running tests

Compile mruby with these 2 gems enabled

```
...
conf.gem github: 'iij/mruby-require'
conf.gem github: 'iij/mruby-mtest'
...
```

Run `mruby test/**`

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
