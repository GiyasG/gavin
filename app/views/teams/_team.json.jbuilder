json.extract! team, :id, :team_title, :team_name, :team_surname, :team_position, :team_about, :team_dob, :team_sex, :created_at, :updated_at
json.url team_url(team, format: :json)
