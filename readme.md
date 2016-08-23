```
$ docker build -t nami .
$ docker run -it -v path/m:/m nami /bin/bash

# cd m/helloworld
# harpoon install .
# cat /opt/bitnami/com.rickspencer3.helloworld/helloworld.txt
foo

# harpoon uninstall com.rickspencer3.helloworld

# harpoon install . --text=bar
# cat /opt/bitnami/com.rickspencer3.helloworld/helloworld.txt
bar

# harpoon uninstall com.rickspencer3.helloworld

# export T1=baz

# harpoon install . --text=$T1

# cat /opt/bitnami/com.rickspencer3.helloworld/helloworld.txt
baz
```
