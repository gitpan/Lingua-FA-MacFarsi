use ExtUtils::MakeMaker;

require 5.006001;

do "mkheader";

WriteMakefile(
    'NAME'		=> 'Lingua::FA::MacFarsi',
    'VERSION_FROM'	=> 'MacFarsi.pm',
    'ABSTRACT_FROM'	=> 'MacFarsi.pm',
    'AUTHOR'		=> 'SADAHIRO Tomoyuki <SADAHIRO@cpan.org>',
    clean =>  {FILES=> 'fmmacfa.h tomacfa.h'},
);

