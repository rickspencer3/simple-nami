'use strict';

// Executed after $app.postUnpackFiles. This is skipped if the "unpack" command is used instead of "install". It is also the only
// one executed if using the "initialize" command.
$app.postInstallation = function() {
  $file.write("helloworld.txt", $app.text)
};
