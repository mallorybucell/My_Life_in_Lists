class CreateListTable < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string      :name
      t.string      :description
      t.boolean     :ongoing
      t.string      :status
      t.date        :due_date
      t.time        :due_time

      t.timestamp
      t.integer
    end
  end
end
