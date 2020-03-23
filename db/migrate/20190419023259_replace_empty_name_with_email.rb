class ReplaceEmptyNameWithEmail < ActiveRecord::Migration[5.2]
  def up
    User.find_each do |user|
      if user.name.blank? && !user.email.blank?
        user.name = user.email
        user.save!
      end
    end
  end

  def down
  end
end
