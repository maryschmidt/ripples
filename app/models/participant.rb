class Participant < ActiveRecord::Base
  include Clusterable
  include Champion
  include Item

  belongs_to :match

  # Compare two subsets of participants
  def self.compare_participant_subsets(participants_1=Participant.all.limit(1000).order(:id), participants_2=Participant.all.limit(1000).offset(100000).order(:id))

    # Cluster champions for each subset
    champ_hash_1, item_hash_1, clusters_1, mergelist_1, seeds_1, tree_1 = Participant.cluster_champs_by_build(participants_1)
    champ_hash_2, item_hash_2, clusters_2, mergelist_2, seeds_2, tree_2 = Participant.cluster_champs_by_build(participants_2)

    # Extract AP item stats
    items_AP = [3089, 3285, 3290, 3100, 3146, 3003, 3152, 3152, 3135, 3001, 3124, 3027, 3115, 3116, 3023, 3048, 3040, 3041, 3174, 3170, 3157, 3165, 3060]
    items_AP_hash = Hash.new

    items_AP.each do |item|
      if item_hash_1.has_key?(item) && item_hash_2.has_key?(item)
        key = item
        value = {
          'id' => item,
          'name' => item_hash_1[item]['name'],
          'image' => item_hash_1[item]['image'],
          'count1' => item_hash_1[item]['count'],
          'count2' => item_hash_2[item]['count'],
          'plotdata' => [{'name' => 'first', 'cValue' => item_hash_1[item]['count'], 'wValue' => (item_hash_1[item]['wins'] / item_hash_1[item]['count'].to_f)}, {'name' => 'second', 'cValue' => item_hash_2[item]['count'], 'wValue' => (item_hash_2[item]['wins'] / item_hash_2[item]['count'].to_f)}],
          'winrate1' => item_hash_1[item]['wins'] / item_hash_1[item]['count'].to_f,
          'winrate2' => item_hash_2[item]['wins'] / item_hash_2[item]['count'].to_f,
        }
        items_AP_hash[key] = value
      end
    end

    # Extract AP champion stats
    champs_AP = [34, 38, 3, 161, 7, 30, 4, 9, 8, 17, 13, 105, 103, 99, 101, 90, 117, 115, 112, 245, 82, 84, 85, 69, 127, 68, 74, 76, 134, 55, 63, 268, 60, 131, 61, 45, 50, 37, 43, 40, 25, 26, 1, 16, 12, 267, 143, 44, 35, 36, 154, 27, 32, 31, 113, 57, 42, 28, 20, 96, 10, 79, 78, 81, 54, 53]
    champs_AP_hash = Hash.new

    champs_AP.each do |champ|
      if champ_hash_1.has_key?(champ) && champ_hash_2.has_key?(champ)
        if !(champ_hash_1[champ]['items'] & items_AP).empty? || !(champ_hash_2[champ]['items'] & items_AP).empty?
          key = champ
          value = {
            'name' => champ_hash_1[champ]['name'],
            'image' => champ_hash_1[champ]['image'],
            'count1' => champ_hash_1[champ]['count'],
            'count2' => champ_hash_2[champ]['count'],
            'winrate1' => champ_hash_1[champ]['wins'] / champ_hash_1[champ]['count'].to_f,
            'winrate2' => champ_hash_2[champ]['wins'] / champ_hash_2[champ]['count'].to_f,
            'items1' => champ_hash_1[champ]['itemImages'],
            'items2' => champ_hash_2[champ]['itemImages']
          }
          champs_AP_hash[key] = value
        end
      end
    end

    # Extract most changed champions
    champs_delta_hash = Hash.new

    champ_hash_1.each_pair do |champ, value1|
      if champ_hash_2.has_key?(champ)
        value2 = champ_hash_2[champ]
        delta_sq = 0.0

        # Find delta between champs for all items present in both participant subsets
        item_hash_1.each_pair do |item, ival1|
          if item_hash_2.has_key?(item)
            ival2 = item_hash_2[item]

            difference = champ_hash_1[champ]['rawVector'][ival1['index']] - champ_hash_2[champ]['rawVector'][ival2['index']]
            delta_sq += difference**2
          end
        end

        delta = Math.sqrt(delta_sq)

        key = champ
        value = {
          'name' => champ_hash_1[champ]['name'],
          'image' => champ_hash_1[champ]['image'],
          'count1' => champ_hash_1[champ]['count'],
          'count2' => champ_hash_2[champ]['count'],
          'items1' => champ_hash_1[champ]['itemImages'],
          'items2' => champ_hash_2[champ]['itemImages'],
          'delta' => delta
        }

        champs_delta_hash[key] = value
      end
    end

    return [ tree_1,
             tree_2,
             items_AP_hash.values.to_json.html_safe,
             champs_AP_hash.to_json.html_safe,
             champs_delta_hash.to_json.html_safe,
             champ_hash_1.to_json.html_safe,
             champ_hash_2.to_json.html_safe,
             item_hash_1.to_json.html_safe,
             item_hash_2.to_json.html_safe
           ]

  end


  # Cluster champs by build
  def self.cluster_champs_by_build(participants=Participant.all.limit(1000).order(:id))

    # Look up appropriate participants
    # participants = Participant.where(match.region: region, match.match_version: patch)

    champ_hash = Hash.new
    champ_index = 0
    item_hash = Hash.new
    item_index = 0

    # Disallowed items
    ignored_items = [0, 2009, 2004, 2003, 2010, 3361, 3362, 3363, 3364, 2140, 2138, 2139, 2137, 3342, 3341, 3340, 2047, 2041, 2044, 2043]

    items_ignored = 0

    participant_subset = participants
    participant_subset.each do |participant|
      puts "hashes #{participant.id}"
      if !champ_hash.has_key?(participant.champion_id)
        champ_hash[participant.champion_id] = {'index' => champ_index, 'count' => 1, 'wins' => 0, 'name' => self.champion_name_for_id(participant.champion_id.to_s), 'image' => self.champion_image_for_id(participant.champion_id.to_s)}
        if participant.win
          champ_hash[participant.champion_id]['wins'] += 1
        end

        champ_index += 1
      else
        champ_hash[participant.champion_id]['count'] += 1

        if participant.win
          champ_hash[participant.champion_id]['wins'] += 1
        end
      end

      participant.items.each do |item|
        if !ignored_items.include?(item)
          if !item_hash.has_key?(item)
            item_hash[item] = {'index' => item_index, 'count' => 1, 'wins' => 0, 'name' => self.item_name_for_id(item.to_s), 'image' => self.item_image_for_id(item.to_s)}
            if participant.win
              item_hash[item]['wins'] += 1
            end

            item_index += 1
          else
            item_hash[item]['count'] += 1
            if participant.win
              item_hash[item]['wins'] += 1
            end
          end
        else
          items_ignored += 1
        end
      end
    end

    # Assemble champ_matrix
    matrix = champ_matrix(champ_hash, item_hash, participant_subset, ignored_items)

    puts "items_ignored #{items_ignored}"

    # Add labels to champ_hash
    champ_hash.each_pair do |c_key, c_value|
      c_index = c_value['index']
      c_vector = matrix[c_index]

      c_items, c_item_images = label_from_vector(c_vector, item_hash, 8)

      champ_hash[c_key]['rawVector'] = c_vector
      champ_hash[c_key]['items'] = c_items
      champ_hash[c_key]['itemImages'] = c_item_images
    end

    # Cluster
    seeds, clusters, mergelist = hac(matrix)

    # Build tree list
    tree = build_tree(champ_hash, item_hash, mergelist, 0.05)

    # Assemble output and label
    return [champ_hash, item_hash, clusters, mergelist, seeds, tree.to_json.html_safe]

  end

  private

  # Calculate matrix of champions by final items
  def self.champ_matrix(champ_hash, item_hash, participants, ignored_items)

    # Set up array to return
    matrix = Array.new(champ_hash.length) { Array.new(item_hash.length, 0.0) }

    bad_build_vectors = 0
    bad_participants = []

    # Loop through participants
    participants.each do |participant|
      puts "matrix #{participant.id}"
      build_vector = Array.new(item_hash.length, 0.0)
      champ_index = champ_hash[participant.champion_id]['index']

      participant.items.each do |item|
        if !ignored_items.include?(item)
          item_index = item_hash[item]['index']
          build_vector[item_index] += 1
        end
      end

      # Normalize build_vector to unit length
      build_vector = normalize_vector(build_vector)

      # if item vector is only ignored items, then build_vector is all zeros and breaks with divide by zero when normalized
      bad_build_vector_flag = 0
      build_vector.each do |ele|
        if ele.nan?
          bad_build_vector_flag = 1
        end
      end
      if bad_build_vector_flag == 1
        bad_build_vectors += 1
        bad_participants.push(participant)
      end

      # Add it to main matrix
      matrix[champ_index] = matrix[champ_index].zip(build_vector).map { |pair| pair.reduce(&:+) }
    end

    # Check for NaNs and < 0s
    notnums = 0
    lessthanzeros = 0
    badrows = 0

    matrix.each do |row|
      badrowflag = 0
      row.each do |ele|
        if ele.nan?
          notnums += 1
          badrowflag = 1
        elsif ele < 0.0
          lessthanzeros += 1
          badrowflag = 1
        end
      end

      if badrowflag == 1
        badrows += 1
      end
    end

    puts "notnums #{notnums}"
    puts "lessthanzeros #{lessthanzeros}"
    puts "badrows #{badrows}"
    puts "bad_build_vectors #{bad_build_vectors}"
    if !bad_participants.empty?
      puts bad_participants.first.items
    else
      puts "no bad participants"
    end

    # Normalize each vector of main matrix
    matrix.map! { |champ| champ = normalize_vector(champ) }

    # Return
    return matrix

  end

end
