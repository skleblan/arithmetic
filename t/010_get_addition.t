use strict; use warnings;
BEGIN{
  $ENV{DANCER_ENVIRONMENT} = 'testing';
}
use arithmatic;
use Test::More tests => 10;
use Plack::Test;
use HTTP::Request::Common;
use HTTP::Status qw$ :is $;
use Ref::Util qw<is_coderef>;

my $app = arithmatic->to_app;
ok( is_coderef($app), 'Got app' );

my $test = Plack::Test->create($app);
my $result = $test->request( GET '/get/add/1/1' );
ok( $result->is_success, "expect 200 response");
ok( $result->content == 2, "1+1=2");

$result = $test->request( GET '/get/add' );
ok(is_client_error($result->code), "req w/ 0 params");
$result = $test->request( GET '/get/add/3' );
ok(is_client_error($result->code), "req w/ 1 param");

$result = $test->request( GET '/get/add/99999/99999' );
is($result->content, 99999 + 99999, "large number addition");

$result = $test->request( GET '/get/add/0/3' );
is($result->content, 3, "adding 0 and a number");
$result = $test->request( GET '/get/add/0/0' );
is($result->content, 0, "adding 0 and 0");

$result = $test->request( GET '/get/add/3/-2' );
is($result->content, 1, "adding 3 and -2");
$result = $test->request( GET '/get/add/-4/-25');
is($result->content, -29, "adding two neg numbers");

$result = $test->request( GET '/get/add/text/2');
die "what is my preferred behavior in this case?\n";

