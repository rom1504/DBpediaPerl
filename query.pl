use strict;
use dbpedia;

if((scalar @ARGV)!=1)
{
	print("usage: $0 <query>\n");
	exit 1;
}
my ($query)=@ARGV;

my ($type,$result)=dbpedia::get($query);

print($result->[0]."\n");