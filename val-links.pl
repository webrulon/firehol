#!/usr/bin/perl -w

use strict;
use LWP::Simple;
use Data::Dumper;

my %urls = ();

while (<>) {
  while (s/url="([^"]+)"//) {
    push @{$urls{$1}}, "$ARGV:$.";
    if (eof) {
      close(ARGV);
    }
  }
}

for my $url (sort(keys(%urls))) {
  my $lines = join(",", @{$urls{$url}});
  my $u = $url;
  $u =~ s/https?:\/\///;
  if ($u !~ /\//) {
    print "WARNING: Missing a /\n    $url\n    $lines\n";
  } else {
    my $content = get($url);
    print "WARNING: Could not GET\n    $url\n    $lines\n" if (! defined $content);

  }
}

exit 0;
