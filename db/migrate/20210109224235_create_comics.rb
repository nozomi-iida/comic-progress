class CreateComics < ActiveRecord::Migration[6.0]
  def change
    create_table :comics do |t|
      t.string :name
      t.integer :volume
      t.string :image

      t.timestamps
    end
  end
end
