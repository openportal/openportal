class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :picture_thumbnail
      t.string :description

      t.timestamps
    end
  end
end
