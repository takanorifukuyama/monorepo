load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

## go gazelle
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "8663604808d2738dc615a2c3eb70eba54a9a982089dd09f6ffe5d0e75771bc4f",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.23.6/rules_go-v0.23.6.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.23.6/rules_go-v0.23.6.tar.gz",
    ],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "cdb02a887a7187ea4d5a27452311a75ed8637379a1287d8eeb952138ea485f7d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.21.1/bazel-gazelle-v0.21.1.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.21.1/bazel-gazelle-v0.21.1.tar.gz",
    ],
)

## gRPC
http_archive(
    name = "build_stack_rules_proto",
    urls = ["https://github.com/stackb/rules_proto/archive/1d6550fc2e62.tar.gz"],
    sha256 = "113e6792f5b20679285c86d91c163cc8c4d2b4d24d7a087ae4f233b5d9311012",
    strip_prefix = "rules_proto-1d6550fc2e625d47dc4faadac92d7cb20e3ba5c5",
)

go_repository(
    name = "org_golang_google_grpc",
    importpath = "github.com/grpc/grpc-go",
    tag = "v1.16.0",
)

load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies", "go_register_toolchains")

go_rules_dependencies()

go_register_toolchains()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()


## NodeJS
http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "1249a60f88e4c0a46d78de06be04d3d41e7421dcfa0c956de65309a7b7ecf6f4",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/0.38.0/rules_nodejs-0.38.0.tar.gz"],
)

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories")
load("@build_bazel_rules_nodejs//:defs.bzl", "yarn_install")

node_repositories(
    package_json = ["//:package.json"]
)

yarn_install(
    name = "npm",
    package_json = "//:package.json",
    yarn_lock = "//:yarn.lock",
)

load("@npm//:install_bazel_dependencies.bzl", "install_bazel_dependencies")
install_bazel_dependencies()
