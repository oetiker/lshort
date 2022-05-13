use strict;
use warnings;

chomp (my $d = `date +"%B %d, %Y"`);
my ($v, $sha) = @ARGV;
if (defined $sha) {
  $sha = substr $sha, 0, 7;
}

while (<STDIN>) {
  s/^Version.+/Version~$v, $d/ if not (defined $sha);
  s/^Version.+/Nightly version~$v\@$sha, $d/ if (defined $sha);
  print;
}
