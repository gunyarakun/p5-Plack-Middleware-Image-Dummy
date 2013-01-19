# vim: set expandtab ts=4 sw=4 nowrap ft=perl ff=unix :
use strict;
use warnings;
use Test::More;
use Plack::Middleware::Static;
use Plack::Builder;
use Plack::Util;
use HTTP::Request::Common;
use HTTP::Response;
use Plack::Test;

my $handler = builder {
    enable 'Image::Dummy', map_path => '/mount/';
};

test_psgi $handler, sub {
    my $cb = shift;

    subtest 'Basic response without font_path' => sub {
        my $res = $cb->(GET "http://localhost/images/100x100.png");
        is $res->code, 500, 'Response HTTP status';
    };
};

done_testing;
