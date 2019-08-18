class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :team, foreign_key: true
      t.integer :user_id
      t.string :role
      t.integer :owner_id
      t.string :email
      t.timestamps
    end
  end
end
