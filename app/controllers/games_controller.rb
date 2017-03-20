class GamesController < ApplicationController
  def index
    @games = Game.all
    @total_games = @games.count
    total_teams = []

    #For Total Number of Teams
    @games.each do |i|
      total_teams << i.away_team_name
      total_teams << i.home_team_name
    end

    @total_teams = total_teams.uniq
    @number_of_teams = @total_teams.count
    @teams_info =[]

    # For Information of team like away team score, home team score, total wins
    @total_teams.each do |i|
      @ties = []
      teams =[]
      @total_wins =[]
      @total_games_played = Game.where("away_team_name = ? or home_team_name =?", i, i).count
      @away_team_wins= Game.where("away_team_name = ? and away_team_score > home_team_score", i).count
      @home_team_wins= Game.where("home_team_name = ? and home_team_score > away_team_score", i).count
      @ties= Game.where("(away_team_name = ? or home_team_name = ?) and home_team_score = away_team_score", i, i).count
      @total_wins = @away_team_wins + @home_team_wins
      @total_games_lost = @total_games_played - (@total_wins + @ties)
      teams = {"team_name" => i, "wins" => @total_wins, "losses" => @total_games_lost, "ties" => @ties}
      @teams_info << teams
    end

    # Sort Information available according to highest wins
    @teams_info_sorted = @teams_info.sort_by { |k| k["wins"] }

    # Lowest positiion will be the count of total teams
    position = @number_of_teams

    # Win score for the first team sorted according to win score
    win_catch = @teams_info_sorted.first["wins"]
    ties_catch = @teams_info_sorted.first["ties"]
    check_wins_position = []
    @teams_info_sorted.each do |i|
      if i["wins"] == win_catch
        if i["ties"] < ties_catch
          i["position"] = position
          check_wins_position << i["wins"]
          win_catch = check_wins_position
        else
          check_wins_position = i["wins"]
          ties_catch = i["ties"]
          i["position"] = position
        end
        position = position - 1
      elsif i["wins"] > win_catch
        i["position"] = position
        position = position -1
      end
    end

    # Sort Information
    @teams_info_arranged = @teams_info_sorted.reverse

    # OUTPUT JSON RESPONSE
    output_data = JSON.pretty_generate(@teams_info_arranged)
    render json: output_data
  end
end
