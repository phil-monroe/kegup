class AddReminderEmailToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :reminder_email, :string
  end
end
