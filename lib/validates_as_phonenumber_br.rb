module ActiveRecord
  module Validations
    module ClassMethods
      def validates_as_phonenumber_br(*attr_names)
        configuration = {
          :message => I18n.translate('activerecord.errors.messages.invalid', :default => 'invalid' ),
          :with => /\A([1-9]{2})([- ]{0,1})(\d{3}|\d{4})([- ]{0,1})(\d{4})\Z/,
          :allow_nil => true }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)

        validates_format_of attr_names, configuration
      end
    end
  end
end