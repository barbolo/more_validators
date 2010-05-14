module ActiveRecord
  module Validations
    module ClassMethods
      def validates_as_cep(*attr_names)
        configuration = {
          :message => I18n.translate('activerecord.errors.messages.invalid', :default => 'invalid' ),
          :with => /\A(\d{5})([-]{0,1})(\d{3})\Z/,
          :allow_nil => true,
          :allow_blank => true }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)

        validates_format_of attr_names, configuration
      end
    end
  end
end