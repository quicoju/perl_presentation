use feature 'say';

# hash is a list of pairs, note:
# '%', '=>'
#===============================
my %mascot_for = (
  Perl   => 'camel',
  Perl6  => 'camelia',
  Gentoo => 'larry'
 );

# Access an element
# =================
say "Perl's mascot is a $mascot_for{ Perl }";

# test the existence of an element
# ================================
say "I don't know Arch's mascot"
  unless exists $mascot_for{ Arch };

# Access the keys and values of a hash
# ====================================
my @projects = keys   %mascot_for;
my @mascots  = values %mascot_for;

# note the use of join
# ====================
say "The projects: ", join(',', @projects);
say "The mascots:  ", join(',', @mascots );

# sequential access to hash with each
# ===================================
my ($first_project, $first_mascot) = each %mascot_for;
say "The mascot for $first_project is $first_mascot.";

# Hash slicing note the '{}'
# ==========================
$" = ' and ';
say "Two of the mascots are @mascot_for{ @projects[1,2] }.";
