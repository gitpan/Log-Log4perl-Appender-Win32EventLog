use Module::Build;

use 5.006;

my $build = Module::Build->new
    (
     module_name => 'Log::Log4perl::Appender::Win32EventLog',
     license => 'perl',
     requires => {
       'perl'                         => '5.6.1',
       'Log::Log4perl'                => 0,
       'Log::Dispatch::Win32EventLog' => 0.02,
     },
     recommends => {
     },
     build_requires => {
       'Test::More'                 => 0,
       'Win32::EventLog'            => 0,
     },
     create_makefile_pl => 'traditional',
     dist_author        => 'Robert Rothenberg <rrwo at cpan.org>',
);

$build->create_build_script;
