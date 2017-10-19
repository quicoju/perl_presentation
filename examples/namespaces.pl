use feature 'say';

$v = 'this is $v from main.';
say "calling from main $v";

package First;
$v = 'this is $v from First.';
say "calling from First: $v";
say "calling from First: $main::v";

package First::Second;
$v = 'This is a two level namespace';
say "Calling from First::Second: $v";

package main;
say "back to main: $v";
say "              $First::v";
say "              $First::Second::v";
