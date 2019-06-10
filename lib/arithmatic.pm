package arithmatic;
use Dancer2;

our $VERSION = '0.1';

get '/get/add/:first/:second' => sub {
#  if any parameters are missing, plack returns a 404 (url not found)
  my $first_int = route_parameters->get('first');
  my $second_int = route_parameters->get('second');
  return $first_int + $second_int;
};

true;
