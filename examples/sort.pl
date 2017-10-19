use feature ':5.10';
use autodie;

open my $fh, '<', 'passwd.txt';

# Problem:
# sort the passwd file by IUD (third field in a
# ':' separated list).

print <<EOM;

* Slow sort block example *
===========================
EOM
print
  sort { (split /:/, $a)[2] <=> (split /:/, $b)[2] } <$fh>;

seek $fh, 0, 0;

print <<EOM;

* Fast sort block example caching uid *
=======================================
EOM
print map   { $_->[0]                }
      sort  { $a->[1] <=> $b->[1]    }
      map   { [ $_, (split /:/)[2] ] }
      <$fh>;
