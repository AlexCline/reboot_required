reboot_required
=======
*A Puppet module for scheduling reboots of systems with pending updates.

Warning
-------

__This module should not be used if you're running a VM that uses a host-specific kernel.__
Many VPS providers use custom-build, host-specific kernels for the client machines in their environment.  This means the kernel your system is running won't be available from the OS vendor.  This module only detects updates available from the OS repositories and can't detect custom kernels that may be available.

You should check with your hosting provider if you're unsure of what type of kernel your system uses.

Usage
-------

__TODO__

Support
-------

Please file tickets and issues using [GitHub Issues](https://github.com/AlexCline/reboot_required/issues)


License
-------
   Copyright 2013 Alex Cline <alex.cline@gmail.com>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
