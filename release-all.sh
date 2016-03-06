for cross_target in {{linux,win32}-{ia32,x64},darwin-x64}
do
  mkdir -p release
  cd build
  zip ../release/$cross_target $cross_target/tagit{,.exe}
done
