class Participant < ActiveRecord::Base
  include Clusterable
  include Champion

  belongs_to :match

  # Cluster champs by build
  def self.cluster_champs_by_build

    # Look up appropriate participants
    # participants = Participant.where(match.region: region, match.match_version: patch)

    champ_hash = Hash.new
    champ_index = 0
    item_hash = Hash.new
    item_index = 0

    # Disallowed items
    ignored_items = [0, 2009, 2004, 2003, 2010, 3361, 3362, 3363, 3364, 2140, 2138, 2139, 2137, 3342, 3341, 3340, 2047, 2041, 2044, 2043]

    items_ignored = 0

    participant_subset = Participant.all.order(:id)
    participant_subset.each do |participant|
      puts "hashes #{participant.id}"
      if !champ_hash.has_key?(participant.champion_id)
        champ_hash[participant.champion_id] = {'index' => champ_index, 'count' => 1, 'name' => self.champion_name_for_id(participant.champion_id.to_s)['name']}
        champ_index += 1
      else
        champ_hash[participant.champion_id]['count'] += 1
      end

      participant.items.each do |item|
        if !ignored_items.include?(item)
          if !item_hash.has_key?(item)
            item_hash[item] = {'index' => item_index, 'count' => 1}
            item_index += 1
          else
            item_hash[item]['count'] += 1
          end
        else
          items_ignored += 1
        end
      end
    end

    # Assemble champ_matrix
    matrix = champ_matrix(champ_hash, item_hash, participant_subset, ignored_items)

    puts "items_ignored #{items_ignored}"

    # Cluster
    seeds, clusters, mergelist = hac(matrix)

    # Build tree list
    tree = build_tree(champ_hash, mergelist, 0.05)

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
