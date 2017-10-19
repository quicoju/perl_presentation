use strict;
use warnings;
use feature 'say';

my $val = "not empty";

# Boolean Coercion
# ================
#   false for scalars:  "0", undef, ""
#   false for arrays: ()
#   false for hashes: ()
say "Testing Boolean Coercion"
  if $val;


# String coercion
# ===============
# Applied when using string operators

my $scalar = 1e-1;
say  "My number is: " . $scalar * 2;



