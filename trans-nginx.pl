#!/usr/bin/perl

package transnginx;

use nginx;
use Lingua::Translit;
use utf8;
#use open qw(:std :utf8);
use Encode;

sub handler {

my $r = shift;
my $uri= $r->uri;
 $uri = decode("utf8", $uri);
my $result;
my $eng_str = $uri;
my $tr = new Lingua::Translit("GOST 7.79 RUS");
if ($tr->can_reverse()) {
$eng_str =~ s#(.*/filters/(.*/+))##;
    $eng_str =~ s/[А-Яа-я0-9\W]+/$+/g;
        @eng=split(/ /,$eng_str);
        $eng_str2 = $eng_str;
    $eng_str2 =~ s/\b([A-Za-z])+\b/\_$&_/g;
        @eng2=split(/ /,$eng_str2);
$uri =~ s/\b([А-Яа-яёЁ])+\b/-$&-/g;
$result = $tr->translit($uri);
for my $i (0 .. $#eng){
        $result =~ s/$eng[$i]\+?/$eng2[$i]/g;
        }
$result =~ s/ /_/g;
    }
else {	$eng_str =~ s#(.*/filters/(.*/+))##;
	if ($eng_str =~ m/\d+/) {
	$eng_str =~ s/\d+|\W/$+/g;
	}
	@eng=split(/ /,$eng_str);
	$eng_str2 =~ s/\b([A-Za-z])+\b/\_$&_/g;
        @eng2=split(/ /,$eng_str2);
	for my $i (0 .. $#eng){
	$result =~ s/$eng[$i]\+?/$eng2[$i]/g;
	}
	$result =~ s/ /_/g;
    }
	

$r->internal_redirect("https://www.technodom.kz/$result");

return OK;
}
1;
