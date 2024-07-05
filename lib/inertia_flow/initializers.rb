# frozen_string_literal: true

require "jbuilder"
require_relative "renderer"

Mime::Type.register_alias "application/json", :inertia

ActionController::Renderers.add :inertia do |component, options|
  controller = self

  InertiaFlow::Renderer.new(component, options, controller, request, response).render
end
