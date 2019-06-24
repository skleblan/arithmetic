#
#===============================================================================
#
#         FILE: 011_post_subtraction.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 06/24/2019 12:36:24 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

BEGIN{
  $ENV{DANCER_ENVIRONMENT} = 'testing';
}

use arithmatic;
use Plack::Test;
use HTTP::Request;
use Encode qw( encode_utf8 );
use Test::More tests => 1;                      # last test to print

my $app = arithmatic->to_app;
my $test = Plack::Test->create($app);

my $result;

my $data = encode_utf8("large=5\nsmall=1");
my $http_req = new HTTP::Request("POST", "/post/minus", {}, $data);
$result = $test->request( POST '/post/minus' );
#when writing the code, use body_parameters instead of route_parameters
is($result->content, 4, "basic subtraction test");



