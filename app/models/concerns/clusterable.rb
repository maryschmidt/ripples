module Clusterable
  extend ActiveSupport::Concern

  module ClassMethods

    def test_class_count
      return self.count
    end

    # Hierarchical agglomerative clustering of a matrix
    def hac(matrix)
      # Set target number of clusters
      k = 1
      # Set similarity threshold
      threshold = 0

      # Initialize arrays
      c = Array.new(matrix.length) { Array.new(matrix.length) { Array.new(2, 0.0) } }
      p = c
      j = Array.new(matrix.length, 0.0)
      a = Array.new()
      clusters = Array.new(matrix.length) { Array.new() }

      # Initial similarity matrix and cluster activity array
      matrix.each_with_index do |n, n_index|
        matrix.each_with_index do |i, i_index|
          c[n_index][i_index][0] = dotproduct(n, i)
          c[n_index][i_index][1] = i_index
        end
        j[n_index] = 1
        clusters[n_index].push(n_index)
      end

      # Sort similarity matrix into priority queue
      c.each_with_index do |c_n, index|
        p[index] = c_n.sort { |x,y| y[0] <=> x[0] }
      end

      # Remove self similarities from priority queue
      p.each_with_index do |p_n, index|
        p_n.delete_if { |item| item[1] == index }
      end

      # Main clustering loop
      (j.length - 1 - k).times do |count|
        #Find the clusters to merge
        k_1 = 0
        k_2 = 0
        max_sim = 0
        j.each_with_index do |active, index|
          if active == 1
            if p[index][0][0] > max_sim
              k_1 = index
              max_sim = p[index][0][0]
            end
          end
        end
        if max_sim <= threshold
          break
        end
        k_2 = p[k_1][0][1]

        # Record the merge
        a.push([k_1, k_2, max_sim])
        j[k_2] = 0
        clusters[k_1].concat(clusters[k_2])
        clusters[k_2] = nil

        # Recalculate similarities as needed
        p[k_1] = []

        new_length = clusters[k_1].length
        new_sum = Array.new(matrix[0].length, 0.0)
        clusters[k_1].each do |row|
          matrix[row].each_with_index do |ele, index|
            new_sum[index] += ele
          end
        end

        j.each_with_index do |active, index|
          if active == 1 && index != k_1
            p[index].delete_if {|item| item[1] == k_1 || item[1] == k_2 }

            comp_length = clusters[index].length
            comp_sum = Array.new(matrix[0].length, 0.0)
            clusters[index].each do |row|
                matrix[row].each_with_index do |ele, c_index|
                  comp_sum[c_index] += ele
                end
            end

            sum_length = new_length + comp_length
            sum_vectors = Array.new(matrix[0].length, 0.0)
            new_sum.each_with_index do |ele, s_index|
              sum_vectors[s_index] = ele + comp_sum[s_index]
            end

            new_c = (1.0/(sum_length * (sum_length - 1))) * (dotproduct(sum_vectors, sum_vectors) - sum_length)

            p[k_1].push([new_c, index])
            p[index].push([new_c, k_1])
            p[index].sort! { |x,y| y[0] <=> x[0] }
          end
        end

        p[k_1].sort! { |x,y| y[0] <=> x[0] }
      end

      # Prep outputs
      clusters.compact!

      seeds = Array.new(clusters.length) { Array.new(matrix[0].length, 0.0) }
      clusters.each_with_index do |cluster, index|
        cluster.each do |note|
          matrix[note].each_with_index do |ele, e|
            seeds[index][e] += ele
          end
        end
        clen = cluster.length
        seeds[index].map! { |ele| ele/clen }
      end

      [seeds, clusters, a]
    end

    def dotproduct(vect1, vect2)
      size = vect1.length
      sum = 0.0
      i = 0
      while i < size
        sum += vect1[i] * vect2[i]
        i += 1
      end
      sum
    end

    def normalize_vector(vect)
      euclength_raw = 0.0
      vect.each { |ele| euclength_raw += ele**2 }
      euclength = Math.sqrt(euclength_raw)

      if euclength <= 0.0
        return vect
      else
        return vect.map { |ele| ele = ele/euclength }
      end
    end

    def average_vectors(vect1, vect1_weight, vect2, vect2_weight)
      sum_vect = Array.new(vect1.length, 0)

      vect1_weight.times do
        vect1.each_with_index do |ele, index|
          sum_vect[index] += ele
        end
      end

      vect2_weight.times do
        vect2.each_with_index do |ele, index|
          sum_vect[index] += ele
        end
      end

      total_weight = vect1_weight + vect2_weight
      sum_vect.each_with_index do |ele, index|
        sum_vect[index] = ele/total_weight
      end

      sum_vect
    end

    def build_tree(ref_hash, label_hash, merge_list, threshold_interval)
      # Initialize tree hash
      tree = Hash.new

      # Build initial tree from reference hash of known format
      ref_hash.each do |key, value|
        tree_key = value['index']
        tree_value = {'index' => tree_key, 'id' => key, 'name' => value['name'], 'winrate' => (value['wins'] / value['count']), 'size' => value['count'], 'image' => value['image'], 'items' => value['itemImages'], 'vector' => value['rawVector'], 'vectorCount' => 1}

        tree[tree_key] = tree_value
      end

      threshold = 1.0 - threshold_interval

      # Restructure tree hash based on merge_list
      merge_list.each do |merge|
        k_1 = merge[0]
        k_2 = merge[1]
        similarity = merge[2]

        hash_1 = tree.delete(k_1)
        hash_2 = tree.delete(k_2)
        hash_1_vector = hash_1['vector']
        hash_2_vector = hash_2['vector']
        hash_1_count = hash_1['vectorCount']
        hash_2_count = hash_2['vectorCount']

        hash_1.delete('vector')
        hash_1.delete('vectorCount')
        hash_2.delete('vector')
        hash_2.delete('vectorCount')

        new_vector = average_vectors(hash_1_vector, hash_1_count, hash_2_vector, hash_2_count)
        new_vectorCount = hash_1_count + hash_2_count
        hash_items, hash_item_images = label_from_vector(new_vector, label_hash, 8)

        if similarity >= threshold
          # Extract children if the exist
          if hash_1.has_key?('children')
            hash_1 = hash_1['children']
          end

          if hash_2.has_key?('children')
            hash_2 = hash_2['children']
          end

          tree[k_1] = {'index' => k_1, 'children' => [hash_1, hash_2].flatten(1), 'items' => hash_item_images, 'vector' => new_vector, 'vectorCount' => new_vectorCount}

        else

          threshold = threshold - threshold_interval
          tree[k_1] = {'index' => k_1, 'children' => [hash_1, hash_2], 'items' => hash_item_images, 'vector' => new_vector, 'vectorCount' => new_vectorCount}

        end
      end


      final_vector = Array.new(ref_hash.values[0]['rawVector'].length , 0)
      final_vector_count = 0

      if tree.length > 1
        tree.each_pair do |key, value|
          final_vector = average_vectors(final_vector, final_vector_count, value['vector'], value['vectorCount'])
          value.delete('vector')
          value.delete('vectorCount')
        end
        final_items, final_item_images = label_from_vector(final_vector, label_hash, 8)

        values_array = tree.values
        tree_result = {'index' => 0, 'children' => values_array, 'items' => final_item_images}
      else
        tree.each_value do |value|
          value.delete('vector')
          value.delete('vectorCount')
        end

        values_array = tree.values
        tree_result = values_array
      end

      return tree_result
    end

    def label_from_vector(vect, ref_hash, label_count)
      # Protect the input vector
      vector = vect.dup

      labels = Array.new()
      label_images = Array.new()

      label_count.times do
        vectmax = vector.max
        if vectmax > 0
          i = vector.index(vectmax)

          ref_hash.each_pair do |key, value|
            if value['index'] == i
              labels.push(key)
              label_images.push(value['image'])
              break
            end
          end

          vector[i] = 0

        else
          break
        end
      end

      [labels, label_images]

    end

  end
end
