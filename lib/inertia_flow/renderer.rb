# frozen_string_literal: true

require "jbuilder/jbuilder_template"

module InertiaFlow
  class Renderer
    attr_accessor :component, :options, :controller, :request, :response

    def initialize(component, options, controller, request, response)
      @component = component
      @options = options
      @controller = controller
      @request = request
      @response = response
    end

    def render
      props = jbuilder_attributes

      InertiaRails::Renderer.new(
        component,
        controller,
        request,
        response,
        render_method,
        props: props,
        view_data: options[:view_data]
      ).render
    end

    private

    def jbuilder_attributes
      jbuilder = JbuilderTemplate.new(view_context)

      # Render the Jbuilder template into the Jbuilder object
      view_context.render(template: template,
                          formats: [:inertia],
                          handlers: [:jbuilder],
                          locals: { json: jbuilder })

      # Get the Ruby hash from the Jbuilder object
      jbuilder.attributes!
    end

    def template
      "#{controller_path}/#{action_name}"
    end

    def render_method
      controller.method(:render)
    end

    def view_context
      controller.view_context
    end

    def controller_path
      controller.controller_path
    end

    def action_name
      controller.action_name
    end
  end
end
