require_relative '../systemd/mixin'
require_relative 'manager'

module DBus
  module Machined
    class Machine
      INTERFACE = 'org.freedesktop.machine1.Machine'

      include DBus::Systemd::Mixin::MethodMissing

      def initialize(name, manager = Manager.new)
        machine_path = manager.GetMachine(name).first
        @object = manager.service.object(machine_path)
                                 .tap(&:introspect)
      end
    end
  end
end
