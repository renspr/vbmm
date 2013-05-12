class AddVbIdToMember < ActiveRecord::Migration
  def change
    add_column :members, :vb_id, :integer
  end
end
