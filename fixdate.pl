# Copyright (C) 2022 Tobias Oetiker, Marcin Serwin
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

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
