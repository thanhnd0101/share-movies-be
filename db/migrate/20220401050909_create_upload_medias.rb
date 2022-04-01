class CreateUploadMedias < ActiveRecord::Migration[7.0]
  def change
    create_table :upload_medias do |t|
      t.integer :media_type
      t.string :url
      t.string :meta_data
      t.references :document, null: false, foreign_key: true

      t.timestamps
    end
  end
end
