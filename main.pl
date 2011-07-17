#!/usr/bin/perl -w
use strict;
use Curses;

my $status = new Curses;

my %player = (
    'health' => 100,
    'x' => 5,
    'y' => 5,
);

sub processThings {
    my $_ = getch;
    if (/[hjkl]/) { &walking($_); }
    else { &displayStatus("badkey"); }
}
sub displayStatus {
    my ($_) = @_;
    if (/badkey/) { addstr(20,5,"Sorry, I don't know what that key does."); }
    else { addstr(20,5,"You moved to the $_"); }
}
sub walking {
    my ($_) = @_;
    my $dir;
    if (/h/) { $player{x}--; $dir = 'left'; };
    if (/j/) { $player{y}++; $dir = 'down'; };
    if (/k/) { $player{y}--; $dir = 'up'; };
    if (/l/) { $player{x}++; $dir = 'right'; };
    clear;
    &displayStatus($dir);
}

initscr;

while(1) {
    addch($player{y},$player{x},"@");
    move($player{y},$player{x});
    refresh;
    &processThings;
}

endwin;
