require 'test/unit'

begin
  require File.dirname(__FILE__) + '/../../../../config/boot'
  require 'active_record'
  require 'i18n'
  require 'validates_as_phonenumber_br'
rescue LoadError
  require 'rubygems'
  require 'active_record'
  ActiveRecord::ActiveRecordError # work-around to solve problems with ActiveRecord::Validations
  require 'i18n'
  require File.dirname(__FILE__) + '/../lib/validates_as_phonenumber_br'
end

class TestRecord < ActiveRecord::Base
  def self.columns; []; end
  attr_accessor :phonenumber_br
  validates_as_phonenumber_br :phonenumber_br
end

class ValidatesAsPhoneNumberBRTest < Test::Unit::TestCase
  def test_illegal_phonenumber_br
    values = [
      '1234',
      '11111111111111111',
      'name???',
      '11/5555-1111',
      '11555511115'
      ]
    values.each do |value|
      assert !TestRecord.new(:phonenumber_br => value).valid?, "#{value} should be illegal."
    end
  end

  def test_legal_phonenumber_br
    values = [
      '11-5555-5555',
      '11-555-5555',
      '1155555555',
      '115555555',
      '11 5555 5555',
      '11 555 5555',
      '11-5555 5555',
      '11 555-5555']
      
    values.push('')
      
    values.each do |value|
      assert TestRecord.new(:phonenumber_br => value).valid?, "#{value} should be legal."
    end
  end
end