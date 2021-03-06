#
# Copyright (C) 2016 Nathan Williams <nath.e.will@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
require_relative 'helpers'
require_relative 'mixin'

module DBus
  module Systemd
    class Timedated
      # the timedated dbus node path
      NODE = '/org/freedesktop/timedate1'.freeze

      # the timedated dbus service & interface
      SERVICE = INTERFACE = 'org.freedesktop.timedate1'.freeze

      include Mixin::MethodMissing
      include Mixin::Properties

      # @return [DBus::Service]
      # @api private
      attr_reader :service

      #
      # Create a new object for interfacing with timedated
      #
      # @param bus [DBus::SystemBus, DBus::SessionBus] dbus instance
      def initialize(bus = Helpers.system_bus)
        @service = bus.service(SERVICE)
        @object = @service.object(NODE)
        @object.default_iface = INTERFACE
        @object.introspect
      end
    end
  end
end
