module ActiveRecord
  module Validations
    module ClassMethods
      def validates_as_website(*attr_names)
        configuration = {
          :message => I18n.translate('activerecord.errors.messages.invalid', :default => 'invalid' ),
          :with => /\A(http|https)[:]\/{2}[^\/.]+([.][^\/.]+)+.*\Z/i,
          :allow_nil => true }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)

        validates_format_of attr_names, configuration
      end
    end
  end
end