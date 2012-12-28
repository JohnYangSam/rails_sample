class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    # Arguments are: (table, col, type)
    add_column :users, :password_digest, :string
  end
end
