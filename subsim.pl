#!/usr/bin/env perl
#
# subsim
# Copyright (C) 2009 Davide Mancusi <arekfu@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;
use List::Util 'shuffle';
use WWW::Wikipedia;

binmode(STDOUT, ":utf8");
binmode(DATA, ":utf8");

my @phrases;

while( <DATA> ) {
	chomp;
	push(@phrases,$_);
}
my $wiki = WWW::Wikipedia->new();
my $randpage = $wiki->random();
if( $randpage )
{
	my $text=$randpage->text();
	while( $text =~ /</ )
	{
		$text =~ s/<[^<>]*>/ /g;
	}
	while( $text =~ /\{/ )
	{
		$text =~ s/{[^{}]*}/ /g;
	}
	while( $text =~ /\(/ )
	{
		$text =~ s/\([^\(\)]*\)/ /g;
	}
	$text =~ s/\n/ /g;
	$text =~ s/ +/ /g;
	$text =~ s/^ //g;
	$text =~ s/'//g;
	chomp($text = (split(/\.[ \n]/,$text))[0]);
	$text = $text . ". I just read it on Wikipedia.";
	push(@phrases,$text);
}
@phrases = shuffle(@phrases);

my $nphrases = int(rand 5) + 3;

my $pops=0.1;
my $pmeans=$pops + 0.1;
my $psorry=$pmeans + 0.1;
my $plaugh=$psorry + 0.1;
#my $pwhy=$plaugh + 0.1;
#my $pquest=$pwhy + 0.1;
my $pquest=$plaugh + 0.1;
my $pmunch=$pquest + 0.1;

foreach (1 .. $nphrases) {

	my $ptype = rand;

	if( $ptype<$pops )
	{
		print "Ops.";
	}
	elsif( $ptype<$pmeans )
	{
		my $p1=shift @phrases;
		my @words=split(/[^[:alpha:]]/,$p1);
		my $word=$words[$#words];
		my $p2=lcfirst(shift(@phrases));
		if( (split(/ /,$p2))[0] eq "i" )
		{
			$p2=ucfirst $p2;
		}
		print $p1 . " " . ucfirst($word) . " means that " . $p2;
	}
	elsif( $ptype<$psorry )
	{
		my $p1=shift @phrases;
		my @words=split(/ /,$p1);
		print join(' ',@words[0 .. (int(rand @words-1)+1)]) . "... no no no, sorry, sorry.";
	}
	elsif( $ptype<$plaugh )
	{
		print "*chuckles*";
	}
#	elsif( $ptype<$pwhy )
#	{
#		my $p1=shift @phrases;
#		my $p2=lcfirst(shift(@phrases));
#		if( (split(/ /,$p2))[0] eq "i" )
#		{
#			$p2=ucfirst $p2;
#		}
#
#		print $p1 . " So that is why " . $p2;
#	}
	elsif( $ptype<$pquest )
	{
		my $p1=lcfirst(shift(@phrases));
		if( (split(/ /,$p1))[0] eq "i" )
		{
			$p1=ucfirst $p1;
		}
		print "So I asked him casually and he answered that $p1";
	}
	elsif( $ptype<$pmunch )
	{
		my $p1=shift @phrases;
		my $nmunch=int(0.1*length $p1);
		my @munches = (
		"munch",
		"ch",
		"smunch",
		"chmunch" );
		foreach ( 1 .. $nmunch ) {
			my $pos=int(rand(length($p1)-2))+1;
			substr($p1,$pos,0) = "£" if substr($p1,$pos-1,2) =~ /[^£[:punct:]][^£[:punct:]]/;
		}
		while( $p1 =~ /£/ ) {
			my $replace = $munches[int(rand @munches)];
			$p1 =~ s/£/*$replace*/;
		}

		print $p1;
	}
	else
	{
		   print shift(@phrases);
	}

	if ($_ == $nphrases)
	{
		print "\n";
	}
	else
	{
		print " ";
	}

}

__END__
Actually my father is already going to give me a great present. I will get a wife this winter.
Yes, many Indian students from Telangana University, Chhattisgarh Swami Vivekanand Technical University, Jamia Millia Islamia University and other Indian universities are getting assaulted in Australia.
Actually most of the Indian students are accused of stealing the jobs of the Australians.
I will cook hot dogs for dinner tonight.
No, the real reason for the crisis is that the loan mortgage bank Central Bank Liquidity Swaps took the loans, bought a house, then sold the house without the mortgage. They told them it would explode. They did not listen.
I can show you some interesting videos about that.
As Gauss said, we are all in the gutter, but some of us are looking at the stars.
Chestnuts can explode in your mouth.
Mmmh, I see.
I like wine. What does "Sauvignon" mean? Yes, I drank twelve bottles in six weeks, but I only drink on weekends.
I think I will go for the milkshake.
You are hitting her with a spoon. Is it the Spanish inquisition?!
Good shot!
