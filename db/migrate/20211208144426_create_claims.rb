class CreateClaims < ActiveRecord::Migration[6.1]
  def change
    create_table :claims, id: :uuid do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.integer :state

      t.timestamps
    end
  end
end
