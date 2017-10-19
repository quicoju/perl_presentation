use strict;
use warnings;

# Example of a typical sub declarations
# =====================================
sub fun_single_paramter {
  my $param = shift;
  print "Param is $param\n";
}

sub fun_ordered_params {
  my ($param1, $param2) = @_;
  print "$param1 then $param2\n";
}

sub fun_named_params {
  my %params = @_;
  print "\u$params{first} \u$params{last} is a $params{profession}\n";
}

fun_single_paramter( "Jump!" );

fun_ordered_params( "Hello", "World" );

fun_named_params(
  profession => 'singer',
  last       => 'fernandez',
  first      => 'vicente',
);
