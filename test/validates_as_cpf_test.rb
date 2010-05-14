require 'test/unit'

begin
  require File.dirname(__FILE__) + '/../../../../config/boot'
  require 'active_record'
  require 'i18n'
  require 'validates_as_cpf'
rescue LoadError
  require 'rubygems'
  require 'active_record'
  ActiveRecord::ActiveRecordError # work-around to solve problems with ActiveRecord::Validations
  require 'i18n'
  require File.dirname(__FILE__) + '/../lib/validates_as_cpf'
end

class TestRecord < ActiveRecord::Base
  def self.columns; []; end
  attr_accessor :cpf
  validates_as_cpf :cpf
end

class ValidatesAsCpfTest < Test::Unit::TestCase
  def test_illegal_cpf
    values = [
      '1234',
      '11111111111111111',
      '1.2.3.4.1',
      'name???',
      '36192118299',
      '227.556.44242',
      '227556.442-42',
      '227556442-42',
      '00000000000'
      ]
    values.each do |value|
      assert !TestRecord.new(:cpf => value).valid?, "#{value} should be illegal."
    end
  end

  def test_legal_cpf
    values = [
      '227.566.442-42',
      '22756644242']
    
    values.push('')
      
    values.each do |value|
      assert TestRecord.new(:cpf => value).valid?, "#{value} should be legal."
    end
  end
end