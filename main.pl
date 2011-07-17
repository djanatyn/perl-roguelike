#!/usr/bin/perl -w
package Player;
use strict;
use Curses;
use Moose;

has 'health' => (is => 'rw', isa => 'Int', default => 100);
has 'x'      => (is => 'rw', isa => 'Int', default => 5);
has 'y'      => (is => 'rw', isa => 'Int', default => 5);

sub walk {
    my ($self,$ch) = @_;
    my %map = (
	h => [0,-1],
	j => [1,0],
	k => [-1,0],
	l => [0,1],
	);
    my ($y,$x) = @{$map{$ch}};
    $self->y($self->y + $y); $self->x($self->x + $x);

    return ($self->y ,$self->x);
}

package main;
use strict;
use Curses;

initscr;

my $player = Player->new;

while(1) {
    clear;
    addch($player->y, $player->x,"@");
    move($player->walk(getch));
    refresh;
}

endwin;
