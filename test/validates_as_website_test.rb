require 'test/unit'

begin
  require File.dirname(__FILE__) + '/../../../../config/boot'
  require 'active_record'
  require 'i18n'
  require 'validates_as_website'
rescue LoadError
  require 'rubygems'
  require 'active_record'
  ActiveRecord::ActiveRecordError # work-around to solve problems with ActiveRecord::Validations
  require 'i18n'
  require File.dirname(__FILE__) + '/../lib/validates_as_website'
end

class TestRecord < ActiveRecord::Base
  def self.columns; []; end
  attr_accessor :website
  validates_as_website :website
end

class ValidatesAsWebsiteTest < Test::Unit::TestCase
  def test_illegal_website
    values = [
      'http://',
      'http:///',
      'http://www',
      'http://www.'
      ]
    values.each do |value|
      assert !TestRecord.new(:website => value).valid?, "#{value} should be illegal."
    end
  end

  def test_legal_website
    values = [
      'http://www.test.com',
      'http://www.test.com/',
      'https://test.com',
      'https://test.com/',
      'http://www.test.com/test/test/test.html',
      'https://www.test.com/test/test/test.html?test=test']
      
    values.each do |value|
      assert TestRecord.new(:website => value).valid?, "#{value} should be legal."
    end
  end
end