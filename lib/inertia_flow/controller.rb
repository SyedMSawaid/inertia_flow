# frozen_string_literal: true

module InertiaFlow
  module Controller
    extend ActiveSupport::Concern

    included do
      before_action :set_values_for_inertia, if: :inertia_request?
    end

    private

    def inertia_request?
      request.inertia?
    end

    def set_values_for_inertia
      request.format = :inertia
    end

    def default_render
      if inertia_request?
        render(inertia: true)
      else
        super
      end
    end
  end
end
