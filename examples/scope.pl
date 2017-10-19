use strict;
use warnings;
use feature 'say';

# Scope
#======

# Lexical: my
# ===========
say "Examples for lexical scope";
say "==========================";

my $lexical_scope = 'in main package';
say $lexical_scope;

package Lexical::Scope {
  my $lexical_scope = 'in Lexical::Scope';
  my $lexical_scope_only = 'This one lives in this namespace only';
  say $lexical_scope;
};

{
  my $lexical_scope = "Still in main but in another lexical scope";
  say $lexical_scope;
}

say $lexical_scope;

package Other::Package {
  say "\$lexical_scope isn't visible here.";
};

