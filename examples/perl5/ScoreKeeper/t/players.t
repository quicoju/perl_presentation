#!/usr/bin/env perl

use Test::More tests => 15;
use Test::Exception;
use Test::Deep;

use strict;
use warnings;

BEGIN {
  use_ok('ScoreKeeper');
}

my $a = ScoreKeeper::Player->create( { name => 'PlayerA' } );
my $b = ScoreKeeper::Player->create( { name => 'PlayerB' } );
my $c = ScoreKeeper::Player->create( { name => 'PlayerC' } );

END {
  foreach my $player ( $a, $b, $c ) {
    $player->games->delete_all();
    $player->delete();
  }
}

dies_ok { ScoreKeeper::Player->create( { name => $a->name() } ) }
  'cannot create two players with the same name';

foreach my $tuple ( [11, 8], [9,11], [11, 7], [10, 11], [11, 9] ) {
  my ( $score1, $score2 ) = @$tuple;

  my $g = ScoreKeeper::Game->create( { date => 20170101 } );
  $g->add_to_scores( { player => $a, value => $score1 } );
  $g->add_to_scores( { player => $b, value => $score2 } );
}

my $g2 = ScoreKeeper::Game->create( { date => 20170202 } );
$g2->add_to_scores( { player => $a, value => 11 } );
$g2->add_to_scores( { player => $c, value => 8 } );

is( scalar( $a->games() ), 6 );
is( scalar( $b->games() ), 5 );

is( $a->wins(), 4, "Player A's wins" );
is( $b->wins(), 2, "Player B's wins" );
is( $c->wins(), 0, "Player C's wins" );

is( $a->losses(), 2, "Player A's losses" );
is( $b->losses(), 3, "Player B's losses" );
is( $c->losses(), 1, "Player C's losses" );

is( $a->winning_percentage_against($b), 60, 'A vs B' );
is( $b->winning_percentage_against($a), 40, 'B vs A' );

is( $a->winning_percentage_against($c), 100, 'A vs C' );
is( $c->winning_percentage_against($a), 0,   'C vs A' );

is_deeply(
  [ ScoreKeeper::Player->retrieve_all_ranked() ],
  [ $a, $b, $c ],
  'Players retrieved in the correct order of rank'
 );
