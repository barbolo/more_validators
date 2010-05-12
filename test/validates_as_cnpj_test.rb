require 'test/unit'

begin
  require File.dirname(__FILE__) + '/../../../../config/boot'
  require 'active_record'
  require 'i18n'
  require 'validates_as_cnpj'
rescue LoadError
  require 'rubygems'
  require 'active_record'
  ActiveRecord::ActiveRecordError # work-around to solve problems with ActiveRecord::Validations
  require 'i18n'
  require File.dirname(__FILE__) + '/../lib/validates_as_cnpj'
end

class TestRecord < ActiveRecord::Base
  def self.columns; []; end
  attr_accessor :cnpj
  validates_as_cnpj :cnpj
end

class ValidatesAsCNPJTest < Test::Unit::TestCase
  def test_illegal_cnpj
    values = [
      '1234',
      '11111111111111111',
      '1.2.3.4.1',
      'name???',
      '00000000000',
      '227.566.442-42',
      '22756644242',
      '11111111111111'
      ]
    values.each do |value|
      assert !TestRecord.new(:cnpj => value).valid?, "#{value} should be illegal."
    end
  end

  def test_legal_cnpj
    values = [
      '28.261.861/0001-42',
      '28261861000142']
      
    values.each do |value|
      assert TestRecord.new(:cnpj => value).valid?, "#{value} should be legal."
    end
  end
end