use strict;
use warnings;

package Implicit::Methods 0.01 {
  # ... or;
  # our $VERSION = 0.01;
};

package main;

Implicit::Methods->import();
Implicit::Methods->unimport();
print "Package version is: ", Implicit::Methods->VERSION(), "\n";

# Add a definition to Implicit::Methods from some other package
package Some::Other::Package {
  sub Implicit::Methods::run {
    print "RUNNING from Implicit::Methods\n";
  }
};

package main;
Implicit::Methods::run();

