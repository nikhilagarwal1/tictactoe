class CreateMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :moves do |t|
      t.belongs_to :game, index: true
      t.belongs_to :player, index: true
      t.column :x, :integer
      t.column :y, :integer
      t.column :created_at, :datetime
    end

    add_index :moves, [:x, :y, :game_id], :unique => true
  end
end
