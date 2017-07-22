#include <iostream>

#include <fileref.h>
#include <tstring.h>
#include <tstringlist.h>
#include <tpropertymap.h>

#include <tagit_config.h>

using namespace std;

int main(int argc, char * argv[]) {
  char c = argv[1][0];
  if (c == 'v') {
    cout << PROJECT_VERSION << endl;
    return 0;
  }
  TagLib::FileRef f(argv[argc - 1]);
  TagLib::PropertyMap m(f.file()->properties());
  if (c == 'c') {
    m.clear();
  } else {
    TagLib::String n(argv[2]);
    if (c == 'd') {
      m.erase(n);
    } else if (c == 'g') {
      if (m.contains(n)) {
        TagLib::StringList l = m[n];
        TagLib::String v = l[0];
        std::cout << v.toCString(true) << std::endl;
      } else {
        return 1;
      }
    } else {
      TagLib::String v(argv[3], TagLib::String::UTF8);
      if (c == 'r') {
        m.replace(n, v);
      } else if (c == 'i') {
        m.insert(n, v);
      } else {
        return 1;
      }
    }
  }
  f.file()->setProperties(m);
  f.file()->save();
  return 0;
}
