class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.text :about
      t.string :genre
      t.timestamps
    end
  end
end
