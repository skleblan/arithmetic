use strict; use warnings;

use arithmatic;
use Test::More tests => 3;
use Plack::Test;
use HTTP::Request::Common;
use Ref::Util qw<is_coderef>;

my $app = arithmatic->to_app;
ok( is_coderef($app), 'Got app' );

my $test = Plack::Test->create($app);
my $result = $test->request( GET '/get/add/1/1' );
ok( $result->is_success );
ok( $result->content == 2 );
