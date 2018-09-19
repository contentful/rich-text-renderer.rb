require_relative '../base_node_renderer'

module StructuredTextRenderer
  # hr node renderer
  class HrRenderer < BaseNodeRenderer
    # Renders an hr node
    def render(_node)
      '<hr />'
    end
  end
end
