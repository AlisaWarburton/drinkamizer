class AddImageToDrinks < ActiveRecord::Migration[6.1]
  def change
    add_column :drinks, :image, :string
  end
end
