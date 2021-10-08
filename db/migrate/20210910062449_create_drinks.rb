class CreateDrinks < ActiveRecord::Migration[6.1]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :base
      t.text :recipe
      t.string :about
      t.string :shop

      t.timestamps
    end
  end
end
