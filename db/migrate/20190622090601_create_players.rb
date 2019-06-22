class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :email
      t.belongs_to :game, index: true

      t.timestamps
    end
  end
end
