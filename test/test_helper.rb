ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'ffaker'
require 'factory_girl'
require 'database_cleaner'
require 'mocha'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # Test assertion for attr_protected
  def login_admin
    admin = Admin.create(username: "admin", email: "user@test.com", password: "foobar")
    session[:admin_id] = admin.id
  end

  def admin_login(admin)
    session[:admin_id] = admin.id
    self.current_admin = admin
  end

  def assert_protected_attribute model, attribute
    accessible = model.read_inheritable_attribute(:attr_accessible).to_a.map(&:to_sym)
    protekted = model.read_inheritable_attribute(:attr_protected).to_a.map(&:to_sym)
    all = model.column_names.map(&:to_sym)

    protected_attributes = []
    protected_attributes << protekted if protekted
    protected_attributes << (all - accessible) if accessible
    protected_attributes.flatten!

    assert protected_attributes.include?(attribute), "expected attribute :#{attribute} to be protected"
  end
end
