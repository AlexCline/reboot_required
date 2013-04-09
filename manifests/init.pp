# == Class: reboot_required
#
#
# === Parameters
#
# [*when*]
#   When will the system restart relative to when a new kernel update is
#   detected?
#
#   Values:
#     'this evening': Reboot tonight at midnight.
#     'this weekend': Reboot on Sunday morning at midnight.
#     'next month':   Reboot at midnight on the first of next month.
#     '_ _ _ _ _':    Reboot at the day and time specified using Cron format.
#     'never':        Never reboot when a kernel update is available.
#
# === Variables
#
# [*kernelupdateavailable*]
#
# === Examples
#
#  # Reboot the system the weekend after a kernel update is found.  The reboot
#  # will happen on Sunday morning at midnight.
#  class { reboot_required:
#    when => 'this weekend',
#    message => 'This system has a pending kernel update and is rebooting now.',
#  }
#
#  # Reboot the system on the first day of the month following the detection of
#  # a kernel update
#  class { reboot_required:
#    when => 'next month',
#  }
#
#
#
# === Author
#
# Alex Cline <alex.cline@gmail.com>
#
# === License
#
# Copyright 2013 Alex Cline <alex.cline@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class reboot_required (
        $when    = 'this evening',
        $message = 'Rebooting the system to perform a kernel upgrade' ) {

  # Only reboot if a kernel update is found.
  case $::kernelupdateavailable {
    'true': {

      case $when {
        'this evening', 'this weekend', 'next month': {
          $special = $when ? {
            'this evening' => '@daily',
            'this weekend' => '@weekly',
            'next month'   => '@monthly',
          }

          cron { 'Reboot Required':
            ensure  => present,
            command => "/sbin/shutdown -r now ${message}",
            special => $special,
          }
        }

        /^([\d\*]\s?){5}$/: {
          $sched = split($when, ' ')
          $min   = $sched[0] ? {
            /^(\d)+$/ => $sched[0],
            '*'       => undef,
            default   => undef,
          }
          $hour  = $sched[1] ? {
            /^(\d)+$/ => $sched[1],
            '*'       => undef,
            default   => undef,
          }
          $dayom = $sched[2] ? {
            /^(\d)+$/ => $sched[2],
            '*'       => undef,
            default   => undef,
          }
          $month = $sched[3] ? {
            /^(\d)+$/ => $sched[3],
            '*'       => undef,
            default   => undef,
          }
          $dayow = $sched[4] ? {
            /^(\d)+$/ => $sched[4],
            '*'       => undef,
            default   => undef,
          }

          cron { 'Reboot Required':
            ensure   => present,
            command  => "/sbin/shutdown -r now ${message}",
            minute   => $min,
            hour     => $hour,
            month    => $month,
            monthday => $dayom,
            weekday  => $dayow,
          }
        }

        'never': {
          cron { 'Reboot Required':
            ensure => absent,
          }
        }

        default: {
          fail("Invalid value for 'when' specified: ${when}")
        }
      }
    }

    'false': {
      cron { 'Reboot Required':
        ensure => absent,
      }
    }

  }  # End case $::kernelupdateavailable

}  # End class $::reboot_required











