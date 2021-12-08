class CreateIterinaries < ActiveRecord::Migration[6.1]
  def change
    create_table :iterinaries do |t|
      t.references :claim, null: false, foreign_key: true, type: :uuid
      t.references :flight, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
