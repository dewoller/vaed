#!/usr/bin/perl -w
#
 
use strict;

open A, ">admission.txt" or die "cannot open admission";
open D, ">diagnosis.txt" or die "cannot open diagnosis";
open P, ">procedure.txt" or die "cannot open procedure";
my $id=0;
while (<*.txt>) {
	my $filename=$_;
	print "$filename\n";
	open IN, "<$filename" or die "cannot open $filename\n";
	$filename =~ s/.{6}(.{7}).*/$1/g;
	my $first=1;
	OUTER: while (<IN>) {
		next OUTER if $first++ == 1 ;
		$id++;
		print("$id\n") if $id / 1000 == int($id/1000);
		chomp();
		my @line = split(/\t/);
		print A join("\t", @line[ 0 .. 33 ]);
		print A "\t$filename\t$id\n";
		my $id1=1;
		foreach my $i ( 74 .. 113 ) {
			my $diag=$line[ $i ];
			my $pref = $line[ $i - 40 ];
			last if (!$pref); 
			print D $id, "\t", $id1++,"\t", $pref, "\t", $diag,   "\n"; 
		}

		$id1=1;
		foreach my $i ( 114 .. 153 ) {
			my $proc=$line[ $i ];
			last if (!$proc); 
			print P $id, "\t", $id1++,"\t", $proc, "\n"; 
		}


	}

}
close(A);
close(D);
close(P);
