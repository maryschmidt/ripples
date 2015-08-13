# require 'yajl'

namespace :ripple do
  desc "import matches from JSON"
  task :import_matches, [:server, :patch] => :environment do |t, args|
    # call it like this: rake ripple:import_matches[na,511]

    file = File.absolute_path("./lib/assets/#{args[:server]}_ranked_#{args[:patch]}.json")
    json = File.new(file, 'r')

    parsed_json = Yajl::Parser.parse(json)
    parsed_json.each do |match|
      # create match
      m = Match.new
      m.region = match['region']
      m.queue_type = match['queueType']
      m.match_version = match['matchVersion']
      m.match_duration = match['matchDuration']
      m.match_id = match['matchId']
      m.save!

      # create participants
      match['participants'].each do |participant|
        p = m.participants.new

        # basic info
        p.participant_id = participant['participantId']
        p.team_id = participant['teamId']
        p.champion_id = participant['championId']
        p.timeline = participant['timeline']

        # base stats
        p.win = participant['stats']['winner']
        p.gold_earned = participant['stats']['goldEarned']
        p.gold_spent = participant['stats']['goldSpent']
        p.kills = participant['stats']['kills']
        p.deaths = participant['stats']['deaths']
        p.assists = participant['stats']['assists']

        # construct array of items
        p.items = []
        (0..6).each {|n| p.items << participant['stats']["item#{n}"]}

        # extrapolate role from role + lane
        riot_role = participant['timeline']['role']
        riot_lane = participant['timeline']['lane']

        if riot_role == 'SOLO'
          # top and mid lanes
          if riot_lane == 'TOP'
            p.role = 'TOP'
          elsif riot_lane == 'MID' || riot_lane == 'MIDDLE'
            p.role = 'MIDDLE'
          end

        elsif riot_lane == 'JUNGLE'
          # jungle
          p.role = 'JUNGLE'

        elsif riot_lane == 'BOT' || riot_lane == 'BOTTOM'
          # bot
          if riot_role == 'DUO_CARRY'
            p.role = 'DUO_CARRY'
          elsif riot_role == 'DUO_SUPPORT'
            p.role = 'DUO_SUPPORT'
          end

        else
          # chaos
          p.role = 'NONE'
        end

        p.save!
      end
    end
  end
end
