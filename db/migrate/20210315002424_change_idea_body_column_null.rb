class ChangeIdeaBodyColumnNull < ActiveRecord::Migration[6.1]
  def change
    change_column :ideas, :body, :text, null: false
  end
end
