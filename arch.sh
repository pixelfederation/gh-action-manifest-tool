get_arch() {
case $(uname -m) in
  *aarch64*|*arm64*)
    export ARCH=arm64
    ;;
  *arm|*aarch)
    export ARCH=arm
    ;;
  *386*)
    export ARCH=386
    ;;
  *x86_64*)
    export ARCH=amd64
    ;;
esac
}


get_os() {
case $(uname | tr '[:upper:]' '[:lower:]') in
  linux*)
    export OS=linux
    ;;
  darwin*)
    export OS=darwin
    ;;
  msys*)
    export OS=windows
    ;;
  *)
    export OS=notset
    ;;
esac
}

get_arch
get_os
