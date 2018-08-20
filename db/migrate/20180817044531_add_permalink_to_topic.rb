class AddPermalinkToTopic < ActiveRecord::Migration[5.1]
  def change
  	add_column :topics, :slug, :string, index: true
  end
end
