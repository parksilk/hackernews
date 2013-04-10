class CreatePostvotes < ActiveRecord::Migration
  def change
    create_table :post_votes do |t|
      t.boolean    :vote_status
      t.references :user
      t.references :post

      t.timestamps
    end
  end
end
