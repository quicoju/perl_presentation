#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

print <<EOM;

Running Python code
===================
EOM

use Inline Python => <<'END_OF_PYTHON';
def add(x,y):
    return x + y
def subtract(x,y) : 
    return x - y
END_OF_PYTHON

say "9 + 16 = ", add(9, 16);
say "9 - 16 = ", subtract(9, 16);


print <<EOM;

Running C code
==============
EOM

use Test::More tests => 6;
use Inline C =>
  Config =>
    LIBS => '-lm',
    ENABLE => 'AUTOWRAP'
;

Inline->import( C => <<END_HEADERS );
  double fmax( double, double );
  double fmin( double, double );
END_HEADERS

is( fmax( 1.0, 2.0 ), 2.0, 'fmax() should find maximum of two values' );
is( fmax(-1.0, 1.0 ), 1.0, 'fmax() should find maximum of two values' );
is( fmax(-1.0,-7.0 ),-1.0, 'fmax() should find maximum of two values' );
is( fmin( 9.3, 1.7 ), 1.7, 'fmin() should find minimum of two values' );
is( fmin( 2.0,-1.0 ),-1.0, 'fmin() should find minimum of two values' );
is( fmin(-1.0,-6.0 ),-6.0, 'fmin() should find minimum of two values' );
