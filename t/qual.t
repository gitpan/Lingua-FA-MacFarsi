
BEGIN { $| = 1; print "1..28\n"; }
END {print "not ok 1\n" unless $loaded;}

use Lingua::FA::MacFarsi ();
$loaded = 1;
print "ok 1\n";

####

print 1
   && "" eq Lingua::FA::MacFarsi::encode("")
   && "" eq Lingua::FA::MacFarsi::decode("")
   && "Perl" eq Lingua::FA::MacFarsi::encode("Perl")
   && "Perl" eq Lingua::FA::MacFarsi::decode("Perl")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

$ampLR = "\x{202D}\x2B\x{202C}";
$ampRL = "\x{202E}\x2B\x{202C}";

print $ampLR eq Lingua::FA::MacFarsi::decode("\x2B")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print $ampRL eq Lingua::FA::MacFarsi::decode("\xAB")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x2B" eq Lingua::FA::MacFarsi::encode($ampLR)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\xAB" eq Lingua::FA::MacFarsi::encode($ampRL)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x{C4}" eq Lingua::FA::MacFarsi::decode("\x80")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x80" eq Lingua::FA::MacFarsi::encode("\x{C4}")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x{6D2}" eq Lingua::FA::MacFarsi::decode("\xFF")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\xFF" eq Lingua::FA::MacFarsi::encode("\x{6D2}")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

$longEnc = "\x24\x20\x28\x29";
$longUni = "\x{202D}\x{0024}\x{0020}\x{0028}\x{0029}\x{202C}";

print $longUni eq Lingua::FA::MacFarsi::decode($longEnc)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print $longEnc eq Lingua::FA::MacFarsi::encode($longUni)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print 1
   && "\0" eq Lingua::FA::MacFarsi::encode("\0")
   && "\0" eq Lingua::FA::MacFarsi::decode("\0")
   && "\cA" eq Lingua::FA::MacFarsi::encode("\cA")
   && "\cA" eq Lingua::FA::MacFarsi::decode("\cA")
   && "\t" eq Lingua::FA::MacFarsi::encode("\t")
   && "\t" eq Lingua::FA::MacFarsi::decode("\t")
   && "\x7F" eq Lingua::FA::MacFarsi::encode("\x7F")
   && "\x7F" eq Lingua::FA::MacFarsi::decode("\x7F")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print 1
   && "\n" eq Lingua::FA::MacFarsi::encode("\n")
   && "\n" eq Lingua::FA::MacFarsi::decode("\n")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print 1
   && "\r" eq Lingua::FA::MacFarsi::encode("\r")
   && "\r" eq Lingua::FA::MacFarsi::decode("\r")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print 1
   && "0123456789" eq Lingua::FA::MacFarsi::encode("0123456789")
   && "0123456789" eq Lingua::FA::MacFarsi::decode("0123456789")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

#####

$macDigitRL = "\xB0\xB1\xB2\xB3\xB4\xB5\xB6\xB7\xB8\xB9"; # RL only
$uniDigit = "\x{6F0}\x{6F1}\x{6F2}\x{6F3}\x{6F4}\x{6F5}\x{6F6}\x{6F7}\x{6F8}\x{6F9}";
$uniDigitRL = "\x{202E}$uniDigit\x{202C}";

print "0123456789" eq Lingua::FA::MacFarsi::encode($uniDigit)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print 1
   && $uniDigitRL eq Lingua::FA::MacFarsi::decode($macDigitRL)
   && $macDigitRL eq Lingua::FA::MacFarsi::encode($uniDigitRL)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

# round-trip convetion for single-character strings

$allchar = map chr, 0..255;
print $allchar eq Lingua::FA::MacFarsi::encode
	(Lingua::FA::MacFarsi::decode($allchar))
   ? "ok" : "not ok", " ", ++$loaded, "\n";

$NG = 0;
for ($char = 0; $char <= 255; $char++) {
    $bchar = chr $char;
    $uchar = Lingua::FA::MacFarsi::encode
	(Lingua::FA::MacFarsi::decode($bchar));
    $NG++ unless $bchar eq $uchar;
}
print $NG == 0
   ? "ok" : "not ok", " ", ++$loaded, "\n";

# to be downgraded on decoding.
print "\x{C4}" eq Lingua::FA::MacFarsi::decode("\x{80}")
   && "\x{C4}" eq Lingua::FA::MacFarsi::decode(pack 'U', 0x80)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x30" eq Lingua::FA::MacFarsi::encode("\x{06F0}")
   && "\x30" eq Lingua::FA::MacFarsi::encode("\x{202D}\x{06F0}") # with LRO
   && "\xB0" eq Lingua::FA::MacFarsi::encode("\x{202E}\x{06F0}") # with RLO
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x39" eq Lingua::FA::MacFarsi::encode("\x{06F9}")
   && "\x39" eq Lingua::FA::MacFarsi::encode("\x{202D}\x{06F9}") # with LRO
   && "\xB9" eq Lingua::FA::MacFarsi::encode("\x{202E}\x{06F9}") # with RLO
   ? "ok" : "not ok", " ", ++$loaded, "\n";

$hexNCR = sub { sprintf("&#x%x;", shift) };
$decNCR = sub { sprintf("&#%d;" , shift) };

print "a\xC7" eq Lingua::FA::MacFarsi::encode
	(pack 'U*', 0x100ff, 0x61, 0x3042, 0x0627)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "a\xC7" eq Lingua::FA::MacFarsi::encode
	(\"", pack 'U*', 0x100ff, 0x61, 0x3042, 0x0627)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "?a?\xC7" eq Lingua::FA::MacFarsi::encode
	(\"?", pack 'U*', 0x100ff, 0x61, 0x3042, 0x0627)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "&#x100ff;a&#x3042;\xC7" eq Lingua::FA::MacFarsi::encode
	($hexNCR, pack 'U*', 0x100ff, 0x61, 0x3042, 0x0627)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "&#65791;a&#12354;\xC7" eq Lingua::FA::MacFarsi::encode
	($decNCR, pack 'U*', 0x100ff, 0x61, 0x3042, 0x0627)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

