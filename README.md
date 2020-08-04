# monorepo

generic platform

## how to develop?

### how to develop feature?
You have to keep your mind this word; one feature, one issue

#### begin to develop
```shell
git flow feature start [issue number]/[feature description]
```

#### finish to develop
first, create pull request

second, in case of pr is accepted, you can merge branch in your local pc
```shell
git flow feature finish [issue number]/[feature description]]
```


## Bazel

### Gazelle

figure out bazel
```shell
go mod vendor
bazel run //:gazelle -- update
```

## build bazel rules nodejs

[install](https://bazelbuild.github.io/rules_nodejs/install.html)



