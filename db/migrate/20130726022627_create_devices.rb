class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :title

      t.timestamps
    end
  end
end
