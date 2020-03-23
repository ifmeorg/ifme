class SetDefaultPublicationDate < ActiveRecord::Migration[5.0]
  def change
    Moment.update_all("published_at=updated_at")
    Strategy.update_all("published_at=updated_at")
  end
end
