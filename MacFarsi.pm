package Lingua::FA::MacFarsi;

require 5.006001;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

require Exporter;
require DynaLoader;
require AutoLoader;

$VERSION = '0.03';
@ISA = qw(Exporter DynaLoader);
@EXPORT = qw(decodeMacFarsi encodeMacFarsi);
@EXPORT_OK = qw(decode encode);

bootstrap Lingua::FA::MacFarsi $VERSION;
1;
__END__

=head1 NAME

Lingua::FA::MacFarsi - transcode between Mac OS Farsi encoding and Unicode

=head1 SYNOPSIS

(1) using function names exported by default:

    use Lingua::FA::MacFarsi;
    $wchar = decodeMacFarsi($octet);
    $octet = encodeMacFarsi($wchar);

(2) using function names exported on request:

    use Lingua::FA::MacFarsi qw(decode encode);
    $wchar = decode($octet);
    $octet = encode($wchar);

(3) using function names fully qualified:

    use Lingua::FA::MacFarsi ();
    $wchar = Lingua::FA::MacFarsi::decode($octet);
    $octet = Lingua::FA::MacFarsi::encode($wchar);

   # $wchar : a string in Perl's Unicode format
   # $octet : a legacy byte string (i.e. in MacFarsi)

=head1 DESCRIPTION

This module provides decoding from/encoding to Mac OS Farsi encoding
(denoted MacFarsi hereafter).

=head2 Features

=over 4

=item bidi support

Functions provided here should cope with Unicode accompanied
with some directional formatting codes: i.e.
C<PDF> (or C<U+202C>), C<LRO> (or C<U+202D>), and C<RLO> (or C<U+202E>).

=item additional mapping

Extended Arabic-Indic Digits and some related characters in Unicode
are encoded in MacFarsi as if normal digits (C<U+0030>..C<U+0039>)
when they appears in the left-to-right direction.

=back

=head2 Functions

=over 4

=item C<$wchar = decode($octet)>

=item C<$wchar = decodeMacFarsi($octet)>

Converts MacFarsi to Unicode.

C<decodeMacFarsi()> is an alias for C<decode()> exported by default.

=item C<$octet = encode($wchar)>

=item C<$octet = encode($handler, $wchar)>

=item C<$octet = encodeMacFarsi($wchar)>

=item C<$octet = encodeMacFarsi($handler, $wchar)>

Converts Unicode to MacFarsi.

C<encodeMacFarsi()> is an alias for C<encode()> exported by default.

If the C<$handler> is not specified,
any character that is not mapped to MacFarsi is deleted;
if the C<$handler> is a code reference,
a string returned from that coderef is inserted there.
if the C<$handler> is a scalar reference,
a string (a C<PV>) in that reference (the referent) is inserted there.

The 1st argument for the C<$handler> coderef is
the Unicode code point (integer) of the unmapped character.

E.g.

   sub hexNCR { sprintf("&#x%x;", shift) } # hexadecimal NCR
   sub decNCR { sprintf("&#%d;" , shift) } # decimal NCR

   print encodeMacFarsi("ABC\x{100}\x{10000}");
   # "ABC"

   print encodeMacFarsi(\"", "ABC\x{100}\x{10000}");
   # "ABC"

   print encodeMacFarsi(\"?", "ABC\x{100}\x{10000}");
   # "ABC??"

   print encodeMacFarsi(\&hexNCR, "ABC\x{100}\x{10000}");
   # "ABC&#x100;&#x10000;"

   print encodeMacFarsi(\&decNCR, "ABC\x{100}\x{10000}");
   # "ABC&#256;&#65536;"

=back

=head1 CAVEAT

Sorry, the author is not working on a Mac OS.
Please let him know if you find something wrong.

B<Maybe bug?>: The (default) paragraph direction is not resolved.
Does Mac always surround by C<LRO>..C<PDF> or C<RLO>..C<PDF>
the characters with bidirectional type to be overridden?

=head1 AUTHOR

  SADAHIRO Tomoyuki  SADAHIRO@cpan.org

  http://homepage1.nifty.com/nomenclator/perl/

  Copyright(C) 2003-2003, SADAHIRO Tomoyuki. Japan. All rights reserved.

This module is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=head1 SEE ALSO

=over 4

=item Map (external version) from Mac OS Farsi character set to Unicode

http://www.unicode.org/Public/MAPPINGS/VENDORS/APPLE/FARSI.TXT

=item The Bidirectional Algorithm

http://www.unicode.org/unicode/reports/tr9/

=back

=cut
