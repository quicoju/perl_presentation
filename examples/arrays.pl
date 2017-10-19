use feature 'say';

sub sep { say "=" x 50 . "\n" }

my $four = 4;

my @array = ('one', 'two', 'three', $four);
say "Elements of \@array: (@array)"; sep;

say "Single access: Third element \$array[2]:  $array[2]"; sep;

say "Maximum index with \$#array:  $#array"; sep;

$array[100] = 'Hundred and one!';
say "The new maximum index is \$#array =  $#array";
say "And the maximum value is \$array[100] = $array[100]";
say "The array size is: \@array in scalar context " . @array; sep;

$#array = 4;
say "The array size after shrink is: " . @array; sep;

say "Access multiple values: (@array[3, 0, 2])"; sep;

$" = ")(";
say 'New separator $" = ")(" => ' . "(@array[3, 0, 2])";
