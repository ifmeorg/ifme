# encoding: UTF-8
class CreateBootsyImageGalleries < ActiveRecord::Migration

  create_table :bootsy_image_galleries, force: true do |t|
    t.integer  :bootsy_resource_id
    t.string   :bootsy_resource_type
    t.timestamps
  end

end
