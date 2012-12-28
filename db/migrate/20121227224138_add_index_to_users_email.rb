class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    # The index basically adds another datastructure with
    # the email values and pointers to the real entries. The
    # data structure is then sorted so we can go from a linear
    # full-table O(N) search to a O(log(n)) search
    add_index(:users, :email, {:unique => true});
    # Same as:
    # add_index :users, :email, unique: true
  end
end
