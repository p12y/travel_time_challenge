class AddNameToJourney < ActiveRecord::Migration[5.1]
  def change
    add_column :journeys, :name, :string
  end
end
