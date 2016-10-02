require_relative 'manager'

module DBus
  module Systemd
    class Unit
      INTERFACE = 'org.freedesktop.systemd1.Unit'

      attr_accessor :object

      def initialize(name, manager = DBus::Systemd::Manager.new)
        unit_path = manager.object.GetUnit(name).first
        @object = manager.service.object(unit_path)
                                 .tap(&:introspect)
      end

      def method_missing(name, *args, &blk)
        @object.send(name, *args, &blk) if @object.respond_to?(name)
      end
    end
  end
end
