#!/usr/bin/perl
#

my @datadict;
my @sysdict;
my $datapointer;
my $syspointer;


        my $line = <STDIN>;
        print "line length=" . length($line) . "\n";
        my $buffer = substr($line,0,255);
        print "buffer length=" . length($buffer) . "\n";
        chomp($buffer);


for ($i = 0; $i < length($buffer); $i++) {
        $nt = substr($buffer,$i, 1) ;
        #print "next_token: $nt ";
        next_token($nt);
}

sub next_token {
        my $t = $_[0];
        if ($t eq "0" || $t eq "1" || $t eq "2" || $t eq "3" || $t eq "4" || 
            $t eq "5" || $t eq "5" || $t eq "6" || $t eq "7" || $t eq "8" ||
            $t eq "9") { push @datadict,$t;print @datadict; }
    
        if ($t eq "+") { $temp1=pop(@datadict);$temp2=pop(@datadict);$temp3=$temp2+$temp1;push @datadict, $temp3;print @datadict;}

        if ($t eq "-") { $temp1=pop(@datadict);$temp2=pop(@datadict);$temp3=$temp2-$temp1;push @datadict, $temp3;print @datadict;}

        if ($t eq "*") { $temp1=pop(@datadict);$temp2=pop(@datadict);$temp3=$temp2*$temp1;push @datadict, $temp3;print @datadict;}

        if ($t eq "/") { $temp1=pop(@datadict);$temp2=pop(@datadict);$temp3=$temp2/$temp1;push @datadict,$temp3;print @datadict;}      
                   

}

# The challenge here is to (a) implement : symbol expression ; and (b) implement loops. 
#
