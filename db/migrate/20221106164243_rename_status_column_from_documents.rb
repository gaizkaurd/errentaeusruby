class RenameStatusColumnFromDocuments < ActiveRecord::Migration[7.0]
  def change
    rename_column :documents, :status, :state
  end
end
