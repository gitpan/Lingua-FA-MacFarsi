
BEGIN { $| = 1; print "1..28\n"; }
END {print "not ok 1\n" unless $loaded;}

use Lingua::FA::MacFarsi;
$loaded = 1;
print "ok 1\n";

####

print 1
   && "" eq encodeMacFarsi("")
   && "" eq decodeMacFarsi("")
   && "Perl" eq encodeMacFarsi("Perl")
   && "Perl" eq decodeMacFarsi("Perl")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

$ampLR = "\x{202D}\x2B\x{202C}";
$ampRL = "\x{202E}\x2B\x{202C}";

print $ampLR eq decodeMacFarsi("\x2B")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print $ampRL eq decodeMacFarsi("\xAB")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x2B" eq encodeMacFarsi($ampLR)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\xAB" eq encodeMacFarsi($ampRL)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x{C4}" eq decodeMacFarsi("\x80")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x80" eq encodeMacFarsi("\x{C4}")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x{6D2}" eq decodeMacFarsi("\xFF")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\xFF" eq encodeMacFarsi("\x{6D2}")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

$longEnc = "\x24\x20\x28\x29";
$longUni = "\x{202D}\x{0024}\x{0020}\x{0028}\x{0029}\x{202C}";

print $longUni eq decodeMacFarsi($longEnc)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print $longEnc eq encodeMacFarsi($longUni)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print 1
   && "\0" eq encodeMacFarsi("\0")
   && "\0" eq decodeMacFarsi("\0")
   && "\cA" eq encodeMacFarsi("\cA")
   && "\cA" eq decodeMacFarsi("\cA")
   && "\t" eq encodeMacFarsi("\t")
   && "\t" eq decodeMacFarsi("\t")
   && "\x7F" eq encodeMacFarsi("\x7F")
   && "\x7F" eq decodeMacFarsi("\x7F")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print 1
   && "\n" eq encodeMacFarsi("\n")
   && "\n" eq decodeMacFarsi("\n")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print 1
   && "\r" eq encodeMacFarsi("\r")
   && "\r" eq decodeMacFarsi("\r")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print 1
   && "0123456789" eq encodeMacFarsi("0123456789")
   && "0123456789" eq decodeMacFarsi("0123456789")
   ? "ok" : "not ok", " ", ++$loaded, "\n";

#####

$macDigitRL = "\xB0\xB1\xB2\xB3\xB4\xB5\xB6\xB7\xB8\xB9"; # RL only
$uniDigit = "\x{6F0}\x{6F1}\x{6F2}\x{6F3}\x{6F4}\x{6F5}\x{6F6}\x{6F7}\x{6F8}\x{6F9}";
$uniDigitRL = "\x{202E}$uniDigit\x{202C}";

print "0123456789" eq encodeMacFarsi($uniDigit)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print 1
   && $uniDigitRL eq decodeMacFarsi($macDigitRL)
   && $macDigitRL eq encodeMacFarsi($uniDigitRL)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

# round-trip convetion for single-character strings

$allchar = map chr, 0..255;
print $allchar eq encodeMacFarsi(decodeMacFarsi($allchar))
   ? "ok" : "not ok", " ", ++$loaded, "\n";

$NG = 0;
for ($char = 0; $char <= 255; $char++) {
    $bchar = chr $char;
    $uchar = encodeMacFarsi(decodeMacFarsi($bchar));
    $NG++ unless $bchar eq $uchar;
}
print $NG == 0
   ? "ok" : "not ok", " ", ++$loaded, "\n";

# to be downgraded on decoding.
print "\x{C4}" eq decodeMacFarsi("\x{80}")
   && "\x{C4}" eq decodeMacFarsi(pack 'U', 0x80)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x30" eq encodeMacFarsi("\x{06F0}")
   && "\x30" eq encodeMacFarsi("\x{202D}\x{06F0}") # with LRO
   && "\xB0" eq encodeMacFarsi("\x{202E}\x{06F0}") # with RLO
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "\x39" eq encodeMacFarsi("\x{06F9}")
   && "\x39" eq encodeMacFarsi("\x{202D}\x{06F9}") # with LRO
   && "\xB9" eq encodeMacFarsi("\x{202E}\x{06F9}") # with RLO
   ? "ok" : "not ok", " ", ++$loaded, "\n";

$hexNCR = sub { sprintf("&#x%x;", shift) };
$decNCR = sub { sprintf("&#%d;" , shift) };

print "a\xC7" eq
	encodeMacFarsi(pack 'U*', 0x100ff, 0x61, 0x3042, 0x0627)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "a\xC7" eq
	encodeMacFarsi(\"", pack 'U*', 0x100ff, 0x61, 0x3042, 0x0627)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "?a?\xC7" eq
	encodeMacFarsi(\"?", pack 'U*', 0x100ff, 0x61, 0x3042, 0x0627)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "&#x100ff;a&#x3042;\xC7" eq
	encodeMacFarsi($hexNCR, pack 'U*', 0x100ff, 0x61, 0x3042, 0x0627)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

print "&#65791;a&#12354;\xC7" eq
	encodeMacFarsi($decNCR, pack 'U*', 0x100ff, 0x61, 0x3042, 0x0627)
   ? "ok" : "not ok", " ", ++$loaded, "\n";

