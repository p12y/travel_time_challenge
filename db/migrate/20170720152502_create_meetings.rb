class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.string :postcode
      t.time :duration
      t.string :name
      t.belongs_to :journey, foreign_key: true

      t.timestamps
    end
  end
end
