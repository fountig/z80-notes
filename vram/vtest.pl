#!/usr/bin/perl
#

$start = 0xc000;
$bytes = $ARGV[0] ;

	print "org &9c40\n";
	print "ld a,2\n";
	print "call &bc0e\n";


for ($i = $start; $i < $start+$bytes; $i++) 
{
	
	my $hex_i = sprintf('%04X', $i);
	print "ld hl, &$hex_i\n";
	print "ld (hl), &FF\n";
	print "\n";


}

	print "noret:\n";
	print "jp noret\n";


