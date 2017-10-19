#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

# Variables (Sigils)
# ==================

# Sigils: Scalar ($)
my $string = 'one';
my $number = 1;

# Sigils: Array (@)
my @strings = ('one', 'two', 'three');
              # same as qw(one two three)
my @numbers = (1, 2 , 3);

# Sigils: Hash (%)
my %number_for = (one => 1, two => 2, three => 3);

# Scalar access
my $name    = $strings[0];          # to Array
my $number2 = $number_for{ one };   # to Hash

# as lvalue
$strings[0] = 'one one';
$number_for{ one } = 11;

# Array access
my @names = @strings[0,2];
my @numbers2 = @number_for{ 'one', 'three' };


# Scope
#======

# Lexical: package
my $lexical_scope = 'in main package';

package Lexical::Scope {
  my $lexical_scope = 'in Lexical::Scope';
  my $lexical_scope_only = 'This one lives in this namespace only';
};

package Other::Package {
  # $lexical_scope_only not visible here
};


# Values
#=======

# strings
my $single_quoted_str = 'To be or not to be.';
my $double_quoted_str = "Interpolate a variable: $name.";


# Lists
my $count = () = return_list(); # Force list evaluation
my @number_list  = (1, 2, 3, 4, 5);
my @number_list_2 =  1 .. 5;
my @farm   = qw!horse chicken goat pig cow!;
my ($package, $filename, $line) = caller();


# Auxiliary functions
# ===================

sub return_list {
  return qw(one two three four five)
}

# Print evaluation context
# ========================
sub context {
  my $context = wantarray;

  say defined $context
       ? $context
           ? 'List'
           : 'Scalar'
       : 'Void';

  return 0;
}


# Aliasing of iterator values in for loops
# ========================================
say join(',', @numbers,);
$_ **= 2 for (@numbers);


# Named loops and continue *(LABELS don't work in re.pl)*
# ========================
my @outs = map { "out-$_" } 0 .. 9;
my @ins  = map { "in-$_"  } 0 .. 9;

OUT:
for my $out (@outs) {
  last if ($out eq "out-8");
  IN:
  for my $in (@ins) {
    next OUT unless ($out eq "out-5");
    say "processing $out in $in";
  }
} continue {
  # not executed on last or redo
  say "Force this out - $out";
}
