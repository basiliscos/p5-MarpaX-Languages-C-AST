#!perl -T
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'MarpaX::Languages::C::AST::Util' ) || print "Bail out!\n";
}

diag( "Testing MarpaX::Languages::C::AST::Util $MarpaX::Languages::C::AST::Util::VERSION, Perl $], $^X" );