class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.integer :punk_id
      t.string :tagline
      t.string :description
      t.float :abv
      t.datetime :seen_at

      t.belongs_to :user

      t.timestamps
    end
  end
end
