#!/usr/bin/perl -w

#@num = (19,23,10,-10,0,-30,51);

chomp ( $num = <STDIN> );

@num = split( /,/, $num);

@sum = sort {$a<=>$b} @num;
print "@sum\n";
