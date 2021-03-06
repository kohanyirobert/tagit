if [[ $CROSS_TARGET == linux-ia32 ]]
then
  CROSS_TRIPLE=i386-linux-gnu
elif [[ $CROSS_TARGET == linux-x64 ]]
then
  CROSS_TRIPLE=x86_64-linux-gnu
elif [[ $CROSS_TARGET == win32-ia32 ]]
then
  CROSS_TRIPLE=i686-w64-mingw32
elif [[ $CROSS_TARGET == win32-x64 ]]
then
  CROSS_TRIPLE=x86_64-w64-mingw32
elif [[ $CROSS_TARGET == darwin-x64 ]]
then
  CROSS_TRIPLE=x86_64-apple-darwin
else
  exit 1
fi

if [[ $CROSS_TARGET == 'linux-ia32' ]]
then
  image=kohanyirobert/crossbuild-i386-linux-gnu:latest
else
  image=multiarch/crossbuild:latest
fi

# INFO: MSYS2 mangles path names for Docker.
# https://stackoverflow.com/questions/53014998
# https://github.com/msys2/msys2/wiki/Porting#filesystem-namespaces
# http://www.mingw.org/wiki/posix_path_conversion
MSYS2_ARG_CONV_EXCL="*" docker run \
  --rm \
  --interactive \
  --volume $PWD:/workdir \
  --workdir /workdir \
  --env CROSS_TARGET=$CROSS_TARGET \
  --env CROSS_TRIPLE=$CROSS_TRIPLE \
  $image << EOF
mkdir -p build/$CROSS_TARGET
cd build/$CROSS_TARGET
cmake ../..
make
EOF
