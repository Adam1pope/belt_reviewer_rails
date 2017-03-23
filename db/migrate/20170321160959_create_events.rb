class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.string :state
      t.string :city
      t.references :host, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
