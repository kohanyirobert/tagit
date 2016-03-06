for cross_target in {{linux,win32}-{ia32,x64},darwin-x64}
do
  if [ -z ${PARALLEL+x} ]
  then
    CROSS_TARGET=$cross_target ./build.sh
  else
    CROSS_TARGET=$cross_target ./build.sh &
  fi
done
wait
