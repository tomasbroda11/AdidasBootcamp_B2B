class AddImageLinkToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :image_link, :string
  end
end
