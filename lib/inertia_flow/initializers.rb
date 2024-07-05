# frozen_string_literal: true

require_relative "renderer"

Mime::Type.register_alias "application/json", :inertia

ActionController::Renderers.add :inertia, InertiaFlow::Renderer
