# vim: set expandtab ts=4 sw=4 nowrap ft=perl ff=unix :
use strict;
use warnings;
use Module::Build;

my $class = Module::Build->subclass(
    class => 'Module::Build::For::GitHub',
    code  => q{
        sub ACTION_docs {
            use Pod::Select;
            use Pod::Readme;

            my $self = shift;

            unlink 'README';
            unlink 'README.pod';
            podselect({ -output => 'README.pod' }, 'lib/Plack/Middleware/Image/Dummy.pm');

            my $pod_parser = Pod::Readme->new;
            $pod_parser->parse_from_file('README.pod', 'README');

            return $self->SUPER::ACTION_docs;
        }
    }
);

my $build = $class->new(
    module_name => 'Plack::Middleware::Image::Dummy',
    dist_author =>
      'Tasuku SUENAGA a.k.a. gunyarakun <tasuku-s-cpanATATtitech.ac>',
    license => 'perl',

    requires => {
        perl                        => '5.008005',
        'parent'                    => '0',
        'Imager'                    => '0.94',
        'Imager::File::GIF'         => '0.86',
        'Plack::Builder'            => '0',
        'Plack::Middleware::Static' => '0',
    },
    configure_requires => { 'Module::Build' => '0.38' },
    build_requires     => {},
    test_requires      => {
        'Test::More'     => '0.98',
        'Test::Requires' => '0',
        'Plack::Test'    => '0',
    },

    no_index => { 'directory' => ['inc', 'author'] },

    test_files => (-d '.git' || $ENV{RELEASE_TESTING}) ? 't/ xt/' : 't/',
    recursive_test_files => 1,

    create_readme  => 1,
    create_license => 1,
);
$build->create_build_script();
