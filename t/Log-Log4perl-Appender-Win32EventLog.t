#-*- mode: perl;-*-

use strict;
use warnings;

use Test::More tests => 7;

use_ok('Log::Log4perl');
use_ok('Log::Log4perl::Appender::Win32EventLog');


my $config = qq{
    log4perl.logger.test              = INFO, EventLog

    log4perl.appender.EventLog        = Log::Log4perl::Appender::Win32EventLog
    log4perl.appender.EventLog.layout = Log::Log4perl::Layout::SimpleLayout
    log4perl.appender.EventLog.source = MySource
  };

Log::Log4perl::init( \$config );

my $log = Log::Log4perl->get_logger('test');
ok($log);

$log->info("this is a test - please ignore");

use Win32;
use Win32::EventLog;


ok(open_log());

my $event = _get_last_event();
ok( $event );

ok( $event->{Strings} =~ /INFO - this is a test - please ignore/ );

ok(close_log());

my $hnd;

sub open_log {
  return $hnd = new Win32::EventLog("Application", Win32::NodeName);
}

sub close_log {
  if ($hnd) {
    $hnd->Close;
    $hnd = undef;
    return 1;
  }
  return;
}

sub _get_last_event {
  my $event = { };
  if ($hnd->Read(
    EVENTLOG_BACKWARDS_READ | EVENTLOG_SEQUENTIAL_READ, 0, $event)) {
    return $event;
  } else {
    print "\x23 WARNING: Unable to read event log";
    return;
  }
}

