use strict;
use warnings;

chomp (my $d = `date +"%B %d, %Y"`);
my ($v, $sha) = @ARGV;
if (defined $sha) {
  $sha = substr $sha, 0, 7;
}

while (<STDIN>) {
  s/!versionplaceholder!/Version~$v, $d/ if not (defined $sha);
  s/!versionplaceholder!/Nightly version~$v\@$sha, $d/ if (defined $sha);
  print;
}
