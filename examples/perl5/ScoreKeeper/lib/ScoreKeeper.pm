package ScoreKeeper;

use 5.006;
use strict;
use warnings;

use Class::DBI::Loader;
use Class::DBI::Loader::Relationship;

=head1 NAME

ScoreKeeper - Keep track of Tennis scores

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

my $loader = Class::DBI::Loader->new(
  dsn       => 'dbi:SQLite:dbname=keeper.db',
  namespace => 'ScoreKeeper',
 );

$loader->relationship( 'a game has scores' );
$loader->relationship( 'a player has games with scores' );

=head1 SYNOPSIS

Keep track of tennis scores

Perhaps a little code snippet.

    use ScoreKeeper;

    my $player_1 = ScoreKeeper::Player->create( { name => 'Player_1' } );
    my $player_2 = ScoreKeeper::Player->create( { name => 'Player_2' } );
    my $game     = ScoreKeeper::Game->create( { date => 20170101 } );

    $game->add_to_scores( { player => $player_1, value => 10 } );
    $game->add_to_scores( { player => $player_2, value => 15 } );

    say "$player_1->{name} has " . $player_1->games() . ' games.';
    say "$player_1->{name} has " . $player_1->wins() . ' wins.';

    say "$player_1->{name} has "
        . $player_1->winning_percentage_against( $player_2 )
        . " winning percentage against $player_2->{name}."

    my @rank = ScoreKeeper::Player->retrieve_all_ranked();

=head1 METHODS ScoreKeeper::Game

=head2 is_winner( $player )

Returns either true or false if $player won the game.

=cut
package ScoreKeeper::Game;

sub is_winner {
    my ($self, $player ) = @_;

  my @scores =
    sort {
      return 0 unless $a and $b;
      $b->value <=> $a->value
    }
    $self->scores();

  return $player eq $scores[0]->player();
}

=head2 has_player( $player )

Returns either true or false if $player played in current game

=cut

sub has_player {
  my ($self, $player) = @_;
  ( $player == $_->player() ) && return 1 for $self->scores();
  return 0;
}

=head1 METHODS ScoreKeeper::Player

=head2 wins()

Returns number of won games by the player

=cut

package ScoreKeeper::Player;

sub wins {
  my $self = shift;
  return scalar grep { $_->is_winner($self) } $self->games();
}

=head2 losses 

Returns number of lost games by player

=cut

sub losses {
  my $self = shift;
  return scalar $self->games() - $self->wins();
}

=head2 winning_percentage_against

Returns the winning percentage of player against another player

=cut

sub winning_percentage_against {
  my ($self, $other) = @_;
  my @all = grep { $_->has_player( $other) } $self->games();
  my @won = grep { $_->is_winner( $self ) } @all;

  return @won / @all * 100;
}

=head2 retrieve_all_ranked

Retrieves a sorted list of players ranked by wins

=cut

sub retrieve_all_ranked {
  my $self = shift;
  return sort { $b->wins() <=> $a->wins() } $self->retrieve_all();
}

=head2 opponents

Returns a player list of the opponents of current player

=cut

sub opponents {
  my $self = shift;
  my %seen_players;

  $seen_players{$_}++ for map { $_->player } map { $_->scores } self->games;
  delete $seen_players{$self};

  return grep { exists $seen_players{$_} } $self->retrieve_all;
}

=head1 AUTHOR

Francisco Jurado, C<< <fjurado at cimat.mx> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-scorekeeper at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=ScoreKeeper>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc ScoreKeeper


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=ScoreKeeper>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/ScoreKeeper>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/ScoreKeeper>

=item * Search CPAN

L<http://search.cpan.org/dist/ScoreKeeper/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2017 Francisco Jurado.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of ScoreKeeper
