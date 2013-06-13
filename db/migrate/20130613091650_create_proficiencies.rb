class CreateProficiencies < ActiveRecord::Migration
  def change
    create_table :proficiencies do |t|
      t.references :user
      t.references :skill
      t.integer :years
      t.boolean :formal

    end
  end
end
