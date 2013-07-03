require 'nokogiri'

module RDiaTool
  class DiaParser

    attr_accessor :object_id

    def get_dia_attribute_string(uml_node,attribute_name)
      uml_node.xpath("./dia:attribute[@name='#{attribute_name}']/dia:string").inner_html
    end

    def get_dia_attribute_type_val(uml_node,attribute_name,val_type)
      uml_node.xpath("./dia:attribute[@name='#{attribute_name}']/dia:#{val_type}/@val").to_s
    end

    def get_dia_attribute_enum(uml_node,attribute_name)
      get_dia_attribute_type_val(uml_node,attribute_name,'enum')
    end

    def get_dia_attribute_boolean(uml_node,attribute_name)
      get_dia_attribute_type_val(uml_node,attribute_name,'boolean')
    end

    def get_dia_string(uml_node,attribute_name)
      trim_pounds(get_dia_attribute_string(uml_node,attribute_name))
    end

    def get_dia_enum(uml_node,attribute_name)
      return_value = get_dia_attribute_enum(uml_node, attribute_name)
      if !return_value.nil?
        return_value=return_value.to_i
      end
      return_value
    end

    def get_dia_boolean(uml_node,attribute_name)
      return_value = to_boolean(get_dia_attribute_boolean(uml_node, attribute_name))
    end

    private

    def trim_pounds(target)
      duplicate = target
      if target[-1,1] == '#'
        duplicate = target[0..-2]
      end

      if target[0,1] == '#'
        duplicate = duplicate[1..-1]
      end
      duplicate
    end

    def to_boolean(boolean_value)
      match = boolean_value =~ /(true|t|yes|y|1)$/i
      boolean_value == true || match != nil
    end

    protected

    def set_basics(target_node)
      self.object_id = target_node.attr('id').to_s
    end

  end
end
