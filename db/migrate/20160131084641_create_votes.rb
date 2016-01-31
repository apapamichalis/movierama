class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :like, :default => 0
      t.integer :hate, :default => 0

      t.timestamps null: false
    end
  end
end
