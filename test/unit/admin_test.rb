require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def new_admin(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    admin = Admin.new(attributes)
    admin.valid? # run validations
    admin
  end

  def setup
    Admin.delete_all
  end

  def test_valid
    assert new_admin.valid?
  end

  def test_require_username
    assert_equal ["can't be blank"], new_admin(:username => '').errors[:username]
  end

  def test_require_password
    assert_equal ["can't be blank"], new_admin(:password => '').errors[:password]
  end

  def test_require_well_formed_email
    assert_equal ["is invalid"], new_admin(:email => 'foo@bar@example.com').errors[:email]
  end

  def test_validate_uniqueness_of_email
    new_admin(:email => 'bar@example.com').save!
    assert_equal ["has already been taken"], new_admin(:email => 'bar@example.com').errors[:email]
  end

  def test_validate_uniqueness_of_username
    new_admin(:username => 'uniquename').save!
    assert_equal ["has already been taken"], new_admin(:username => 'uniquename').errors[:username]
  end

  def test_validate_odd_characters_in_username
    assert_equal ["should only contain letters, numbers, or .-_@"], new_admin(:username => 'odd ^&(@)').errors[:username]
  end

  def test_validate_password_length
    assert_equal ["is too short (minimum is 4 characters)"], new_admin(:password => 'bad').errors[:password]
  end

  def test_require_matching_password_confirmation
    assert_equal ["doesn't match confirmation"], new_admin(:password_confirmation => 'nonmatching').errors[:password]
  end

  def test_generate_password_hash_and_salt_on_create
    admin = new_admin
    admin.save!
    assert admin.password_hash
    assert admin.password_salt
  end

  def test_authenticate_by_username
    Admin.delete_all
    admin = new_admin(:username => 'foobar', :password => 'secret')
    admin.save!
    assert_equal admin, Admin.authenticate('foobar', 'secret')
  end

  def test_authenticate_by_email
    Admin.delete_all
    admin = new_admin(:email => 'foo@bar.com', :password => 'secret')
    admin.save!
    assert_equal admin, Admin.authenticate('foo@bar.com', 'secret')
  end

  def test_authenticate_bad_username
    assert_nil Admin.authenticate('nonexisting', 'secret')
  end

  def test_authenticate_bad_password
    Admin.delete_all
    new_admin(:username => 'foobar', :password => 'secret').save!
    assert_nil Admin.authenticate('foobar', 'badpassword')
  end
end

# == Schema Information
#
# Table name: admins
#
#  id            :integer         not null, primary key
#  username      :string(255)
#  email         :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

