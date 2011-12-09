use Test::Base;
use JSON::XS;

use strict;
use warnings;
#use Smart::Comments;

use lib './lib';
use QAT::Validator;

plan tests => 7;

my $json_xs = JSON::XS->new->utf8->allow_nonref;

run {
    my $block = shift;

    my $name = $block->name;
    my $spec = $block->spec;

    my $validator = QAT::Validator->new(spec => $spec);

    my $valid = $block->valid;
    for my $ln (split /\n/, $valid) {
        ### $ln
        my $data = $json_xs->decode($ln);
        eval {
            $validator->validate($data);
        };
        ok !$@, $name . ": " .  $ln;
    }

    my $invalid = $block->invalid;
    for my $ln (split /\n/, $invalid) {
        ### $ln
        my $data = $json_xs->decode($ln);
        eval {
            $validator->validate($data);
        };
        ok $@, $name . ": " . $ln;
    }
};


__END__
=== TEST 1
--- spec
{ foo: STRING }
--- valid
{"foo":"dog"}
{"foo":32}
null
{}
--- invalid
{"foo2":32}
[]
32