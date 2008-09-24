chomp ($d = `date +"%B %d, %Y"`);
$v = pop @ARGV;
while (<>) {
 s/^Version.+/Version~$v, $d/;
 print;
}
