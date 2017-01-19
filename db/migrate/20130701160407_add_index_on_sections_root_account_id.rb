class AddIndexOnSectionsRootAccountId < ActiveRecord::Migration[4.2]
  tag :postdeploy
  disable_ddl_transaction!

  def self.up
    add_index :course_sections, :root_account_id, algorithm: :concurrently
  end

  def self.down
    remove_index :course_sections, :root_account_id
  end
end
