use strict;
use warnings;

use Test::More tests => 136;

BEGIN { use_ok 'Range::Date' };

my $tests = eval do { local $/; <DATA>; };
die "Data eval error: $@" if $@;

die "Nothing to test!" unless $tests;

require 't/tests.pl';

run_tests( $tests );

__DATA__
[
    'Range::Date' => [
        # Custom code
        undef,

        # Invalid input
        [ '197001', '9999-99-99', '2000-W54', '1970-02-29' ],

        # Valid input
        [ '2000-02-25/2000-03-03', '1970-01-01', '1999-12-31' ],

        # Valid in() items
        [ qw(2000-02-25 2000-02-26 2000-02-27 2000-02-28 2000-02-29
             2000-03-01 2000-03-02 2000-03-03 1970-01-01 1999-12-31) ],

        # Not in() input
        [ qw(2000-02-20 2000-02-21 2000-02-22 2000-02-23 2000-02-24
             1969-12-31 1970-01-02) ],

        # Not in() output
        [ qw(2000-02-20 2000-02-21 2000-02-22 2000-02-23 2000-02-24
             1969-12-31 1970-01-02) ],

        # List context range() output
        [ qw(1970-01-01 1999-12-31 2000-02-25 2000-02-26 2000-02-27
             2000-02-28 2000-02-29 2000-03-01 2000-03-02 2000-03-03) ],

        # Scalar context range() output
        '1970-01-01,1999-12-31,2000-02-25,2000-02-26,2000-02-27,'.
        '2000-02-28,2000-02-29,2000-03-01,2000-03-02,2000-03-03',

        # List context collapsed() output
        [ '1970-01-01', '1999-12-31',
          { start => '2000-02-25', end => '2000-03-03', count => 8 }, ],

        # Scalar context collapsed() output
        '1970-01-01,1999-12-31,2000-02-25/2000-03-03',

        # Initial range size()
        10,

        # add() input
        [ '2012-03-30/2012-04-03; 2012-04-04; 2012-04-05/2012-04-07' ],

        # Valid in() items after add()
        [ qw(1970-01-01 1999-12-31 2000-02-25 2000-02-26 2000-02-27
             2000-02-28 2000-02-29 2000-03-01 2000-03-02 2000-03-03
             2012-03-30 2012-03-31 2012-04-01 2012-04-02 2012-04-03
             2012-04-04 2012-04-05 2012-04-06 2012-04-07) ],

        # Not in() input after add()
        [ qw(2000-02-20 2000-02-21 2000-02-22 2000-02-23 2000-02-24
             1969-12-31 1970-01-02 2012-02-20 2012-02-21 2012-02-22
             2012-02-23 2012-02-24 2012-02-25 2012-02-26 2012-02-27
             2012-02-28 2012-02-29 2012-03-01 2012-03-02 2012-03-03) ],

        # Not in() output
        [ qw(2000-02-20 2000-02-21 2000-02-22 2000-02-23 2000-02-24
             1969-12-31 1970-01-02 2012-02-20 2012-02-21 2012-02-22
             2012-02-23 2012-02-24 2012-02-25 2012-02-26 2012-02-27
             2012-02-28 2012-02-29 2012-03-01 2012-03-02 2012-03-03) ],

        # List context range() output after add()
        [ qw(1970-01-01 1999-12-31 2000-02-25 2000-02-26 2000-02-27
             2000-02-28 2000-02-29 2000-03-01 2000-03-02 2000-03-03
             2012-03-30 2012-03-31 2012-04-01 2012-04-02 2012-04-03
             2012-04-04 2012-04-05 2012-04-06 2012-04-07) ],

        # Scalar range() output after add()
        '1970-01-01,1999-12-31,2000-02-25,2000-02-26,2000-02-27,'.
        '2000-02-28,2000-02-29,2000-03-01,2000-03-02,2000-03-03,'.
        '2012-03-30,2012-03-31,2012-04-01,2012-04-02,2012-04-03,'.
        '2012-04-04,2012-04-05,2012-04-06,2012-04-07',

        # List context collapsed() output after add()
        [ '1970-01-01', '1999-12-31',
          { start => '2000-02-25', end => '2000-03-03', count => 8 },
          { start => '2012-03-30', end => '2012-04-07', count => 9 }, ],

        # Scalar context collapsed() output after add()
        '1970-01-01,1999-12-31,2000-02-25/2000-03-03,2012-03-30/2012-04-07',

        # size() after add()
        19,

        # remove() input
        [ '1969-01-01/2012-01-01' ],

        # Valid in() items after remove()
        [ qw(2012-03-30 2012-03-31 2012-04-01 2012-04-02 2012-04-02
             2012-04-03 2012-04-05 2012-04-06 2012-04-07) ],

        # Not in() after remove()
        [ qw(1970-01-01 1999-12-31 2000-02-25 2000-02-26 2000-02-27
             2000-02-28 2000-02-29 2000-03-01 2000-03-02 2000-03-03) ],

        # Not in() output after remove()
        [ qw(1970-01-01 1999-12-31 2000-02-25 2000-02-26 2000-02-27
             2000-02-28 2000-02-29 2000-03-01 2000-03-02 2000-03-03) ],

        # List context range() output after remove()
        [ qw(2012-03-30 2012-03-31 2012-04-01 2012-04-02 2012-04-03
             2012-04-04 2012-04-05 2012-04-06 2012-04-07) ],

        # Scalar context range() output after remove()
        '2012-03-30,2012-03-31,2012-04-01,2012-04-02,2012-04-03,'.
        '2012-04-04,2012-04-05,2012-04-06,2012-04-07',

        # List context collapsed() output after remove()
        [ { start => '2012-03-30', end => '2012-04-07', count => 9 }, ],

        # Scalar context collapsed() output after remove()
        '2012-03-30/2012-04-07',

        # size() after remove()
        9,
    ],
]