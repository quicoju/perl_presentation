#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'ScoreKeeper' ) || print "Bail out!\n";
}

diag( "Testing ScoreKeeper $ScoreKeeper::VERSION, Perl $], $^X" );
