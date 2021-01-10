class AddUserToComics < ActiveRecord::Migration[6.0]
  def change
    add_reference :comics, :user, foreign_key: true
  end
end
