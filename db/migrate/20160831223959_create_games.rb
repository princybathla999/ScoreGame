class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :away_team_name, null: false
      t.string :home_team_name, null: false
      t.integer :away_team_score, null: false
      t.integer :home_team_score, null: false
    end
  end
end
