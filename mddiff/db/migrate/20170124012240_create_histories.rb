class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.datetime :time_exec
      t.text :input_md
      t.text :output_pandoc
      t.text :output_github
      t.text :output_multi

      t.timestamps
    end
  end
end
