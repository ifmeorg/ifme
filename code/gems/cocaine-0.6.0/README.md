# Cocaine has been renamed to Terrapin

Please track further development on [the Terrapin project page](http://github.com/thoughtbot/terrapin).

The final version of this gem simply requires Terrapin. It should not function any
differently from previous versions.

## Upgrading to Terrapin

Upgrading to Terrapin is expected to be as simple as replacing the `Cocaine`
constant with `Terrapin`. That is

```ruby
Cocaine::CommandLine.new("echo", "hello")
```

should become

```ruby
Terrapin::CommandLine.new("echo", "hello")
```

and should continue to work fine.

## License

Copyright 2011-2018 Jon Yurek and thoughtbot, inc. This is free software, and
may be redistributed under the terms specified in the
[LICENSE](https://github.com/thoughtbot/cocaine/blob/master/LICENSE)
file.
