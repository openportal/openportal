class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :description
      t.string :photo_url

      t.timestamps
    end
  end
end
