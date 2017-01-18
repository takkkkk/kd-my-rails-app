class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :person
      t.string :keyword1
      t.string :keyword2
      t.string :keyword3
      t.string :name

      t.timestamps
    end
  end
end
