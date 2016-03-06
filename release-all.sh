mkdir -p release
cd build
for cross_target in {{linux,win32}-{ia32,x64},darwin-x64}
do
  echo $cross_target | grep -Pq '^win32-(ia32|x64)$'
  if [ $? -eq 0 ]
  then
    zip --must-match ../release/$cross_target $cross_target/tagit.exe
  else
    zip --must-match ../release/$cross_target $cross_target/tagit
  fi
done
