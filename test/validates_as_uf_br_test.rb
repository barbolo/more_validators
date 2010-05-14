require 'test/unit'

begin
  require File.dirname(__FILE__) + '/../../../../config/boot'
  require 'active_record'
  require 'i18n'
  require 'validates_as_uf_br'
rescue LoadError
  require 'rubygems'
  require 'active_record'
  ActiveRecord::ActiveRecordError # work-around to solve problems with ActiveRecord::Validations
  require 'i18n'
  require File.dirname(__FILE__) + '/../lib/validates_as_uf_br'
end

class TestRecord < ActiveRecord::Base
  def self.columns; []; end
  attr_accessor :uf_br
  validates_as_uf_br :uf_br
end

class ValidatesAsUFBRTest < Test::Unit::TestCase
  def test_illegal_uf_br
    values = [
      'rh',
      'cc',
      'sao paulo',
      'saop'
      ]
    values.each do |value|
      assert !TestRecord.new(:uf_br => value).valid?, "#{value} should be illegal."
    end
  end

  def test_legal_uf_br
    values = %w(ac al am ap ba ce df es go ma mg ms mt pa pb pe pi pr rj rn ro rr rs sc se sp to
    AC AL AM AP BA CE DF ES GO MA MG MS MT PA PB PE PI PR RJ RN RO RR RS SC SE SP TO)

    values.push('')

    values.each do |value|
      assert TestRecord.new(:uf_br => value).valid?, "#{value} should be legal."
    end
  end
end