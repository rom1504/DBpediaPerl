use strict;
use dbpedia;

my $query = "select distinct ?date where {<http://dbpedia.org/resource/Barack_Obama> <http://dbpedia.org/ontology/birthDate> ?date} LIMIT 100";

my ($type,$result)=dbpedia::get($query);

print($result->[0]."\n");
