class CreateAccount < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :facebook_email
      t.string :facebook_oauth_token
      t.string :tinder_api_token
      t.string :tinder_id
      t.string :tinder_match_id

      t.timestamps
    end
  end
end
