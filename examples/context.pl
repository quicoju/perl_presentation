use feature 'say';

sub context {
  my $c = wantarray;
  say $c ? 'list' : defined $c ? 'scalar' : 'void' . ' context';
}

my $context = context;
my @context = context;
context;
