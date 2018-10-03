class CreateApiSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :api_searches do |t|
      t.string :user_input

      t.timestamps
    end
  end
end
