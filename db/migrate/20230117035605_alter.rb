class Alter < ActiveRecord::Migration[6.1]
  def change
    change_column_default(
      :follow_requests,
      :status,
      "pending",
    )
  end
end
