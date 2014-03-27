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
		$responsetext =~ s/"//g;
		my @response = split("\n",$responsetext);

		return (shift @response,\@response);
	}
	else
	{
		print STDERR $response->{"_content"};
		die "error";
	}
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

