#Introduction
This is project is meant to be an extremely simple introduction into using Nami to configure an installation in different ways. For ease of demonstration, it Docker to demonstrate the installation manually, though normally installing Nami moduled is scripted.

To use this example, clone this repro then build the docker file using the follow command:
```
$ docker build -t nami .
```

Then you can follow the commands below.

The helloworld project simply copies a file named "helloworld.txt" into the expected location under /opt/bitnami/. The context of that file can be configured in different ways.

#Files
The helloworld directory has the following files and directories:
 * bitnami.json  
 * files
 * main.js
 * hc-inputs.json
 * env-inputs.json

##bitnami.json
This file is necessary to describe the essential metadata for the Nami module. Note the "properties" field. This is the key part for this example. This states that there is a property named "text" that is the type text. It also sets a default for the property "foo\n."
```
{
  "id": "helloworld",
  "name": "helloworld",
  "extends": ["Component"],
  "revision": 0,
  "author": {"name": "Rick Spencer", "url": "https://github.com/rickspencer3/simple-nami"},
  "version": "1.0.0",
  "properties": {
    "text":{"type": "text", "default":"foo\n"}
  },
  "exports": {
  },
  "installation": {
  }
}
```

##files
The install command will unpack any files in the files, dir, if needed, and copy the files, if any, to the expected place, which is /opt/bitnami/name-of-the module. So, in this case, /opt/bitnami/helloworld.

There is a single file, here, "helloworld.txt." This file is empty by default. This example will configure that file.

##main.js
This file has the commands that can do different kinds of configuration at different parts in the lifecycle. This example simply configures the copied file after it is copied, so it only has the postInstallation function implemented. The function uses the built in Nami function to write to the file. It uses the built in $app object and looks for the text property that was declared in bitnami.json.

```
'use strict';

$app.postInstallation = function() {
  $file.write("helloworld.txt", $app.text)
};
```
##hc-inputs.json
This file provides a different value for the text property. In this file, the value is hardcoded, so the files is named "hc-inputs.json" for hard coded. Conventionally, a single file called "inputs.json" is used. inputs.json can combine hardcoded values and values supplied by environment variables.
```
{
  "text": "hard-coded\n"
}
```

##env-inputs.json
This file provides a different value for the text property. In this file, the value is read for environment variables, so the files is named "env-inputs.json" for "env". Notice that the file uses the $golabl.env object that is built into Nami. Conventionally, a single file called "inputs.json" is used. inputs.json can combine hardcoded values and values supplied by environment variables.
```
{
  "text": "{{$global.env.T2}}"
}
```

#Examples

##Use default values
```
$ docker run -it -v /Users/rick/nami/helloworld:/helloworld nami /bin/bash
# cd helloworld/
# harpoon install .
# cat /opt/bitnami/helloworld/helloworld.txt
foo
```

##Supply a value directly from the command line
```
$ docker run -it -v /Users/rick/nami/helloworld:/helloworld nami /bin/bash
# cd helloworld/
# harpoon install . --text=bar
# cat /opt/bitnami/helloworld/helloworld.txt
bar
```

##Use magic environment variable
Environment variables named COMPENT_COMPONENTNAME_VARIABLENAME will "just work"
```
$ docker run -it -v /Users/rick/nami/helloworld:/helloworld nami /bin/bash
# export COMPONENT_HELLOWORLD_TEXT="fazzle"
# harpoon install .
# cat /opt/bitnami/helloworld/helloworld.txt
fazzle
```

##Use the hard coded inputs from a file
```
$ docker run -it -v /Users/rick/nami/helloworld:/helloworld nami /bin/bash
# cd helloworld/
# harpoon install . --inputs-file hc-inputs.json
# cat /opt/bitnami/helloworld/
# cat /opt/bitnami/helloworld/helloworld.txt
hard-coded
```

##Use environment variables via inputs
```
$ docker run -it -v /Users/rick/nami/helloworld:/helloworld nami /bin/bash
# export T2=$'bing'
# harpoon install . --inputs-file env-inputs.json
# cat /opt/bitnami/helloworld/helloworld.txt
bing
```
