class CreateCommentvotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.boolean    :vote_status
      t.references :user
      t.references  :comment

      t.timestamps
    end
  end
end
