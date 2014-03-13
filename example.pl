use strict;
use dbpedia;

my $query = "select distinct ?Concept where {[] a ?Concept} LIMIT 100";

my ($type,$result)=dbpedia::get($query);

print($result->[0]."\n");