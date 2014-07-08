package dbpedia;


use strict;
use URI::Escape;
use LWP::UserAgent;
use XML::Simple;

sub get
{
	my ($query)=@_;
	
	my $SERVER = 'http://dbpedia.org';
	my $QUERYURL = $SERVER . '/sparql?format=csv&timeout=30000&debug=on&default-graph-uri=http%3A%2F%2Fdbpedia.org';


	my $escaped = uri_escape($query);


	my $url = $QUERYURL . "&query=" . $escaped;
# 	print($url."\n");
	my $ua = LWP::UserAgent->new();

	my $response = $ua->get($url);

	if ($response->is_success)
	{
		my $responsetext = $response->content;
		my @cars=split("",$responsetext);
		my $new="";
		my $in=0;
		foreach my $car (@cars)
		{
			if(!$in && $car eq ',') {$new.="\t";}
			elsif($car eq '"') {$in=!$in;}
			else {$new.=$car;}
		}
		my @response = split("\n",$new);

		return (shift @response,\@response);
	}
	return ("error",$response->{"_content"});
}

sub keywordSearch
{
	my ($query)=@_;
	my $SERVER = 'http://lookup.dbpedia.org';
	my $QUERYURL = $SERVER . '/api/search.asmx/KeywordSearch';


	my $escaped = uri_escape($query);


	my $url = $QUERYURL . "?QueryString=" . $escaped;
# 	print($url."\n");
	my $ua = LWP::UserAgent->new();

	my $response = $ua->get($url);

	if ($response->is_success)
	{
		my $responsetext = $response->content;
		my $xml = new XML::Simple;
		my $parsedxml = $xml->XMLin($responsetext);

		return $parsedxml->{'Result'};
	}
	else
	{
		die "error";
	}
	
}

1;

