package Log::Log4perl::Appender::Win32EventLog;

use 5.006;
use strict;
use warnings;

use Win32;
use Log::Dispatch::Win32EventLog 0.02;

our $VERSION = '0.02';

sub new {
  my ($class, %options) = @_;
  
  my $self = {
    'LOG' => (Win32::IsWinNT) ?
	      Log::Dispatch::Win32EventLog->new( %options, ) : undef
  };

  bless $self, $class;
}

# There may be problems with Log::Dispatch::Win32EventLog that are
# similar to the problems with Win32::EventLog::Carp prior to v1.30 on
# Perl 5.8.0: "Use of uninitialized value in subroutine entry at
# C:\Perl\site\lib/Win32/EventLog.pm line 199" warnings.

sub log {
  my ($self, %params) = @_;
    $self->{LOG}->log(%params),
      if ($self->{LOG});
}

1;

__END__

=head1 NAME

Log::Log4perl::Appender::Win32EventLog - Log4perl log to WinNT event logs

=head1 SYNOPSIS

  use Log::Log4perl;

  my $config = qq{
    log4perl.logger.whatever          = INFO, EventLog

    log4perl.appender.EventLog        = Log::Log4perl::Appender::Win32EventLog
    log4perl.appender.EventLog.layout = Log::Log4perl::Layout::SimpleLayout
    log4perl.appender.EventLog.source = MySource
  };

  Log::Log4perl::init( \$config );

=head1 DESCRIPTION

Use Log4perl to post to the Windows NT event logs.  See the
L<Log::Log4perl> documentation for more information.

=head1 SEE ALSO

  Log::Log4perl
  Log::Dispatch::Win32::EventLog
  Win32::EventLog
  Win32::EventLog::Carp

=head1 AUTHOR

Robert Rothenberg <rrwo at cpan.org>

=head2 Suggestions and Bug Reporting

Feedback is always welcome.  Please use the CPAN Request Tracker at
L<http://rt.cpan.org> to submit bug reports.

=head1 LICENSE

Copyright (c) 2004 Robert Rothenberg. All rights reserved.  This
program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
