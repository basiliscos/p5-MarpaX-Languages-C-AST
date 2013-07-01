#!env perl
use strict;
use warnings FATAL => 'all';
use MarpaX::Languages::C::AST;
use Log::Log4perl qw/:easy/;
use Log::Any::Adapter;
use Log::Any qw/$log/;
use Data::Dumper;
#
# Init log
#
our $defaultLog4perlConf = <<DEFAULT_LOG4PERL_CONF;
log4perl.rootLogger              = TRACE, Screen
log4perl.appender.Screen         = Log::Log4perl::Appender::Screen
log4perl.appender.Screen.stderr  = 0
log4perl.appender.Screen.layout  = PatternLayout
log4perl.appender.Screen.layout.ConversionPattern = %d %-5p %6P %m{chomp}%n
DEFAULT_LOG4PERL_CONF
Log::Log4perl::init(\$defaultLog4perlConf);
Log::Any::Adapter->set('Log4perl');
#
# Parse C
#
my $file = shift || die "Usage: $^X $0 file\n";
open(FILE, '<', $file) || die "Cannot open $file, $!\n";
my $cSourceCode = do { local $/; <FILE> };
close(FILE) || warn "Cannot close $file, $!\n";
#
# Skip CPP and extensions
#
$cSourceCode =~ s/^\#\s*\w+.*$//mg;
$cSourceCode =~ s/^\[source_annotation_attribute.*$//mg;
my $cAstObject = MarpaX::Languages::C::AST->new();
print Dumper($cAstObject->parse(\$cSourceCode));
