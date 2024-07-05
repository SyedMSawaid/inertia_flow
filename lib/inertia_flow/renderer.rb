# frozen_string_literal: true

module InertiaFlow
  class Renderer
    def call(component, options)
      props = jbuilder_attributes

      InertiaRails::Renderer.new(
        component,
        self,
        request,
        response,
        method(:render),
        props: props,
        view_data: options[:view_data]
      ).render
    end

    private

    def jbuilder_attributes
      jbuilder = JbuilderTemplate.new(view_context)

      # Render the Jbuilder template into the Jbuilder object
      view_context.render(template: "#{controller_path}/#{action_name}",
                          formats: [:inertia],
                          handlers: [:jbuilder],
                          locals: { json: jbuilder })

      # Get the Ruby hash from the Jbuilder object
      jbuilder.attributes!
    end
  end
end
