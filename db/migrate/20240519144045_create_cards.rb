class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :card_type
      t.text :desc
      t.boolean :group

      t.timestamps
    end
  end
end
