class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      
      t.integer:following_id
      t.integer:be_followed_id

      t.timestamps
    end
  end
end
