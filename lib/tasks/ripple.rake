namespace :ripple do
  desc "generate all the data ever"
  task generate_global_comparisons: :environment do
    # rake ripple:generate_global_comparisons

    # 5.11 tree
    participant_set_1 = Participant.includes(:match)
      .where(
        matches: {
          match_version: '5.11.0.270'
        }
      )
      .references(:matches)

    participant_set_2 = Participant.includes(:match)
      .where(
        matches: {
          match_version: '5.14.0.329'
        }
      )
      .references(:matches)

    data_set = Participant.compare_participant_subsets(participant_set_1, participant_set_2)

    tree_511 = data_set[0]
    tree_514 = data_set[1]
    ap_items = data_set[2]
    ap_champs = data_set[3]
    champ_diffs = data_set[4]

    # write output to files
    file_0 = File.new(File.absolute_path("./lib/assets/comparisons/clusters_511_all.json"), 'w+')
    file_0.write(tree_511)
    file_0.close

    file_1 = File.new(File.absolute_path("./lib/assets/comparisons/clusters_514_all.json"), 'w+')
    file_1.write(tree_514)
    file_1.close

    file_2 = File.new(File.absolute_path("./lib/assets/comparisons/ap_items_all.json"), 'w+')
    file_2.write(ap_items)
    file_2.close

    file_3 = File.new(File.absolute_path("./lib/assets/comparisons/ap_champs_all.json"), 'w+')
    file_3.write(ap_champs)
    file_3.close

    file_4 = File.new(File.absolute_path("./lib/assets/comparisons/champ_diffs_all.json"), 'w+')
    file_4.write(champ_diffs)
    file_4.close
  end

  desc "cluster number of participants from given server and patch"
  task :cluster_participants, [:server, :patch] => :environment do |t, args|
    # rake ripple:cluster_participants['NA','5.11.0.270']
    # rake ripple:cluster_participants['NA','5.14.0.329']

    file = File.absolute_path("./lib/assets/clusters/#{args[:server]}_ranked_#{args[:patch]}.json")
    output = File.new(file, 'w+')

    participants = Participant.includes(:match)
      .where(
        matches: {
          region: args[:server],
          match_version: args[:patch]
        }
      )
      .references(:matches)

    clustered_data = Participant.cluster_champs_by_build(participants)

    tree = clustered_data[5]

    output.write(tree)

    output.close
  end

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
