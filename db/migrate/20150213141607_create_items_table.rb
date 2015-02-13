class CreateItemsTable < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string      :name
      t.string      :description
      t.string      :status
      t.date        :due_date
      t.time        :due_time

      t.belongs_to  :list

      t.timestamp
      t.integer
    end
  end
end