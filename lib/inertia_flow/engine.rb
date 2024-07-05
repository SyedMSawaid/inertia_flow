# frozen_string_literal: true

require_relative "controller"

module InertiaFlow
  class Engine < ::Rails::Engine
    initializer "inertia_flow.action_controller" do
      ActiveSupport.on_load(:action_controller_base) do
        include ::InertiaFlow::Controller
      end
    end
  end
end
