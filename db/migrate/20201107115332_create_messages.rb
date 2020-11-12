class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t| #t.timestampsにより:created_at, :updated_atが追加される。また、明示されていないが :idもprimary keyとして生成される。

      t.timestamps
    end
  end
end
