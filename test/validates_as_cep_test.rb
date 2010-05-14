require 'test/unit'

begin
  require File.dirname(__FILE__) + '/../../../../config/boot'
  require 'active_record'
  require 'i18n'
  require 'validates_as_cep'
rescue LoadError
  require 'rubygems'
  require 'active_record'
  ActiveRecord::ActiveRecordError # work-around to solve problems with ActiveRecord::Validations
  require 'i18n'
  require File.dirname(__FILE__) + '/../lib/validates_as_cep'
end

class TestRecord < ActiveRecord::Base
  def self.columns; []; end
  attr_accessor :cep
  validates_as_cep :cep
end

class ValidatesAsCepTest < Test::Unit::TestCase
  def test_illegal_cep
    values = [
      '1234',
      '11111111111111111',
      'name???',
      '1234567890'
      ]
    values.each do |value|
      assert !TestRecord.new(:cep => value).valid?, "#{value} should be illegal."
    end
  end

  def test_legal_cep
    values = [
      '05012-101',
      '01234-000',
      '12345-678']
      
    values.push('')
      
    values.each do |value|
      assert TestRecord.new(:cep => value).valid?, "#{value} should be legal."
    end
  end
end