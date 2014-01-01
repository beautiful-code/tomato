require 'rubygems'
require 'narray'
require 'similar_text'
require 'debugger'

class Util
  SimilarityThreshold = 80

  def self.cluster strings
    dim = strings.length
    matrix = NArray.int(dim, dim)
    clusters = []

    for x in 0..dim-1
      for y in x+1..dim-1
        matrix[x,y] = similarity(strings[x], strings[y])
      end
    end

    #matrix.print_matrix

    for x in 0..dim-1
      for y in x+1..dim-1
        if matrix[x,y] > Util::SimilarityThreshold
          add_to_cluster(strings[x], strings[y], clusters)
        end
      end
    end


    # Create single clusters of single items
    for i in 0..dim-1
      unless member_of(strings[i], clusters)
        clusters << [strings[i]]
      end
    end
    

    debugger
    clusters

  end

  # Returns the cluster of the string
  def self.member_of string, clusters
    clusters.select {|c| c.include?(string)}.first
  end

  def self.add_to_cluster one, two, clusters
    cluster = clusters.select

    one_cluster = clusters.select {|c| c.include?(one)}.first
    two_cluster = clusters.select {|c| c.include?(two)}.first

    one_cluster = member_of one, clusters
    two_cluster = member_of two, clusters

    one_present =  !!one_cluster
    two_present =  !!two_cluster

    if one_present && two_present
      if one_cluster != two_cluster
        # Theoritically you should come here
        # merge the two clusters if they are different
        raise 'merge'
      end
    else
      if one_present
        one_cluster << two
      elsif two_present
        two_cluster << one
      else
        clusters << [one,two]
      end
    end
  end

  def self.similarity one, two
    one.similar two
  end

end

class NArray
  def print_matrix
    len = (Math.sqrt(self.size) - 1).to_i
    for x in 0..len
      for y in 0..len
        printf "%4s", self[x,y]
      end
      puts ""
    end
  end
end



strings = ['ravi', 'bhim', 'rowdyb']
strings = []
strings = ['ravi', 'rowdy', 'rock', 'guava-strudel', 'guava strudel', 'ravi', 'raavi', 'potato balls', 'potato sandwich', 'foo', 'bar']
# strings = ['ravi', 'rowdy', 'rock']
puts Util.cluster(strings)
