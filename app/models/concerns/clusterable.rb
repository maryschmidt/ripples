module Clusterable
  extend ActiveSupport::Concern

  included do
    # This code will be executed in the context of the class that's including the module
  end

  # Write methods here that you need for clustering

  module ClassMethods
    # These are class methods of the class including the module
    # Pretty cool, huh?!?

    def test_class_count
      return self.count
    end

    # Hierarchical agglomerative clustering of a matrix
    def hac(matrix)
      # Set number of clusters (simplest cutoff method)
      k = 0
      # Set similarity threshold
      threshold = 0

      # Initialize arrays
      c = Array.new(matrix.length) { Array.new(matrix.length) { Array.new(2, 0) } }
      p = c
      j = Array.new(matrix.length, 0)
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
        new_sum = Array.new(matrix[0].length, 0)
        clusters[k_1].each do |note|
          matrix[note].each_with_index do |ele, index|
            new_sum[index] += ele
          end
        end

        j.each_with_index do |active, index|
          if active == 1 && index != k_1
            p[index].delete_if {|item| item[1] == k_1 || item[1] == k_2 }

            comp_length = clusters[index].length
            comp_sum = Array.new(matrix[0].length, 0)
            clusters[index].each_with_index do |ele, index|
              comp_sum[index] += ele
            end

            sum_length = new_length + comp_length
            sum_vectors = Array.new(matrix[0].length, 0)
            new_sum.each_with_index do |ele, index|
              sum_vectors[index] += ele + comp_sum[index]
            end

            new_c = (1/(sum_length * (sum_length - 1))) * (dotproduct(sum_vectors, sum_vectors) - sum_length)

            p[k_1].push([new_c, index])
            p[index].push([new_c, k_1])
            p[index].sort! { |x,y| y[0] <=> x[0] }
          end
        end

        p[k_1].sort! { |x,y| y[0] <=> x[0] }
      end

      # Prep outputs
      clusters.compact!

      seeds = Array.new(clusters.length) { Array.new(matrix[0].length, 0) }
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
      sum = 0
      i = 0
      while i < size
        sum += vect1[i] * vect2[i]
        i += 1
      end
      sum
    end

    def normalize_vector(vect)
      euclength_raw = 0
      vect.each { |ele| euclength_raw += ele**2 }
      euclength = Math.sqrt(euclength_raw)

      return vect.map { |ele| ele = ele/euclength } 
    end

    def build_tree(merge_list)
      tree = Hash.new
      merge_count = merge_list.length

      merge_list.reverse_each do |merge|

      end

      return tree
    end
  end
end
