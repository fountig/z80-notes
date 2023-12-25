#!/usr/bin/perl
#
# Amstrad Video RAM db definition generator


my @pixels;

for ($i = 0; $i < 1024; $i++) 
{
	$rint = int(rand(255));
	push @pixels, $rint;
}


	print "org &9c40\n";
	print "ld a,2\n";
	print "call &bc0e\n";

	print "ld de, &0010\n";
	print "ld hl, &00a0\n";

	print "call &bc1d\n";

	print "ld de, sprite1\n";
	print "ld b, 1024\n";
	print "SpriteDraw1:\n";
	print "		push	hl\n";
	print "			ld a, (de)\n";
	print "			ld (hl),a\n";
	print "			inc de\n";
	print "			inc hl\n";
	print " \n";
	print "			ld a,(de)\n";
	print "			ld (hl),a\n";
	print "			inc de\n";
	print "			inc hl\n";
	print "		pop	hl\n";
	print "		call &bc26\n";
	print "		djnz SpriteDraw1\n";

	print "noret:\n";
	print "jp noret\n";

	print "\n";
	print "sprite1:\n";
	for $p (@pixels) 
	{
		print "\t db $p\n ";
	}

