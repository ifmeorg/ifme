# encoding: UTF-8
class CreateBootsyImages < ActiveRecord::Migration

  create_table :bootsy_images, force: true do |t|
    t.string   :image_file
    t.integer  :image_gallery_id
    t.timestamps
  end

end
