class Participant < ActiveRecord::Base
  include Clusterable

  belongs_to :match

  # Cluster champs by build
  def self.cluster_champs_by_build

    # Look up appropriate participants
    # participants = Participant.where(match.region: region, match.match_version: patch)

    champ_hash = Hash.new
    champ_index = 0
    item_hash = Hash.new
    item_index = 0
    participant_subset = Participant.all.limit(10000)
    participant_subset.each do |participant|
      puts "hashes #{participant.id}"
      if !champ_hash.has_key?(participant.champion_id)
        champ_hash[participant.champion_id] = champ_index
        champ_index += 1
      end

      participant.items.each do |item|
        if !item_hash.has_key?(item)
          item_hash[item] = item_index
          item_index += 1
        end
      end
    end

    # Assemble champ_matrix
    matrix = champ_matrix(champ_hash, item_hash, participant_subset)

    # Cluster
    seeds, clusters, mergelist = hac(matrix)

    # Assemble output and label
    return [champ_hash, item_hash, clusters, mergelist]

  end

  private

  # Calculate matrix of champions by final items
  def self.champ_matrix(champ_hash, item_hash, participants)
    # Set up array to return
    matrix = Array.new(champ_hash.length) { Array.new(item_hash.length, 0) }

    # Disallowed items
    ignored_items = []

    # Loop through participants
    participants.each do |participant|
      puts "matrix #{participant.id}"
      build_vector = Array.new(item_hash.length, 0)
      champ_index = champ_hash[participant.champion_id]

      participant.items.each do |item|
        if !ignored_items.include?(item)
          item_index = item_hash[item]
          build_vector[item_index] += 1
        end
      end

      # Normalize build_vector to unit length
      build_vector = normalize_vector(build_vector)

      # Add it to main matrix
      matrix[champ_index] = matrix[champ_index].zip(build_vector).map { |pair| pair.reduce(&:+) }
    end

    # Normalize each vector of main matrix
    matrix.map! { |champ| champ = normalize_vector(champ) }

    # Return
    return matrix

  end

end
