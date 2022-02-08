class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres do |t|
      t.string :name

      t.timestamps
    end

    create_join_table :artists, :genres
  end
end
