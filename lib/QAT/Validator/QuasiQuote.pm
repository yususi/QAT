package QAT::Validator::QuasiQuote;

use strict;
use warnings;

#use Smart::Comments;
use QAT::Validator::Compiler;
require Filter::QuasiQuote;
our @ISA = qw( Filter::QuasiQuote );

#$::RD_HINT = 1;
#$::RD_TRACE = 1;
our $Comp = QAT::Validator::Compiler->new;

sub validator {
    my ($self, $s, $fname, $ln, $col) = @_;
    my $r = $Comp->validator($s, $ln) or
      die "Execution aborted due to syntax errors in validator quasiquotations.\n";
    $r =~ s/\n/ /sg;
    $r;
}

1;

