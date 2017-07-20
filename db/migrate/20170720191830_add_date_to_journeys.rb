class AddDateToJourneys < ActiveRecord::Migration[5.1]
  def change
    add_column :journeys, :start_date, :date
  end
end
