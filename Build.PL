use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    license        => 'perl',
    dynamic_config => 0,

    build_requires => {
        'Test::More'     => '0.98',
        'Test::Requires' => '0',
        'Plack::Test'    => '0',
    },
    configure_requires => { 'Module::Build' => '0.38' },
    requires           => {
        perl                        => '5.008005',
        'parent'                    => '0',
        'Imager'                    => '0.94',
        'Imager::File::GIF'         => '0.86',
        'Plack::Builder'            => '0',
        'Plack::Middleware::Static' => '0',
    },

    no_index    => { 'directory' => ['inc'] },
    name        => 'Plack-Middleware-Image-Dummy',
    module_name => 'Plack::Middleware::Image::Dummy',

    # script_files => [''],

    test_files => (-d '.git' || $ENV{RELEASE_TESTING}) ? 't/ xt/' : 't/',
    recursive_test_files => 1,

    create_readme  => 1,
    create_license => 1,
);
$build->create_build_script();
