class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :organization_id
      t.string :name
      t.string :url
      t.integer :issue_id
      t.string :status
      t.integer :level
      t.text :description

      t.timestamps
    end
  end
end
