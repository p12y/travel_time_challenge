class ChangePostcodeToLocation < ActiveRecord::Migration[5.1]
  def change
    rename_column :meetings, :postcode, :location
  end
end
