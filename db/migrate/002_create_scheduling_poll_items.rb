class CreateSchedulingPollItems < ((Rails.version > "5")? ActiveRecord::Migration[4.2] : ActiveRecord::Migration)
  def change
    create_table :scheduling_poll_items do |t|
      t.integer :scheduling_poll_id, :null => false
      t.integer :position, :default => 1
      t.string :text, :null => false
    end
  end
end
