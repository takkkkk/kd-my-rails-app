class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.integer :person_id
      t.string :person_name

      t.timestamps
    end
  end
end
