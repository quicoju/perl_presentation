use Scalar::Util 'dualvar';
use feature 'say';

my $dual = dualvar(0, "hello");

say $dual + 2;
say $dual . ' world!';

say 'string takes priority over numeric'
  if $dual;

# use case: $!
# ===========
open "fail";
printf "ERROR (%d): %s\n", $!, $!;
