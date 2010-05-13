module UF_BR
  LIST_UP = %w(AC AL AM AP BA CE DF ES GO MA MG MS MT PA PB PE PI PR RJ RN RO RR RS SC SE SP TO)
  LIST_DOWN = %w(ac al am ap ba ce df es go ma mg ms mt pa pb pe pi pr rj rn ro rr rs sc se sp to)

  def self.valid?(uf_br, allow_up = true, allow_down = true)
    (allow_up and LIST_UP.include? uf_br) or (allow_down and LIST_DOWN.include? uf_br)
  end
  
  def self.invalid?(uf_br, allow_up = true, allow_down = true)
    !valid?(uf_br, allow_up, allow_down)
  end
end

module ActiveRecord
  module Validations
    module ClassMethods
      def validates_as_uf_br(*attr_names)
        configuration = {
          :message => I18n.translate('activerecord.errors.messages.invalid', :default => 'invalid' ),
          :allow_nil => true,
          :allow_down => true,
          :allow_up => true }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)

        validates_each attr_names, configuration do |record, attribute, value|
          record.errors.add(attribute, configuration[:message]) if UF_BR.invalid?(value, configuration[:allow_up], configuration[:allow_down])
        end
        
      end
    end
  end
end