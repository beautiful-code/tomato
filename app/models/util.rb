=begin
require 'rubygems'
require 'narray'
require 'similar_text'
require 'debugger'
=end

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

    matrix.print_matrix

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
    

    #debugger
    clusters

  end

  # Returns the cluster of the string
  def self.member_of string, clusters
    clusters.select {|c| c.include?(string)}.first
  end

  def self.add_to_cluster one, two, clusters
    one_cluster = member_of one, clusters
    two_cluster = member_of two, clusters

    one_present =  !!one_cluster
    two_present =  !!two_cluster

    if one_present && two_present
      if one_cluster != two_cluster
        one_cluster.push(two_cluster).flatten!
        clusters.delete(two_cluster)

        # Theoritically you should come here
        # merge the two clusters if they are different
        #raise 'merge'
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
        printf "%3s", self[x,y]
      end
      puts ""
    end
  end
end


=begin

strings = ['ravi', 'bhim', 'rowdyb']
strings = []
strings = ['ravi', 'rowdy', 'rock', 'guava-strudel', 'guava strudel', 'ravi', 'raavi', 'potato balls', 'potato sandwich', 'foo', 'bar']
# strings = ['ravi', 'rowdy', 'rock']
puts Util.cluster(strings)
=end

strings = [
"Medianoche Preparada",
"Potato Balls",
"Fruit Strudels",
"Sandwiches",
"Cuban Sandwich",
"Fruit Tarts",
"Cheese Rolls",
"Service",
"Guava And Cheese Pastries",
"Guava Pastries",
"Cheese Pastries",
"Empanadas",
"Cheese Sticks",
"Dulce De Leche Kisses",
"Tres Leches Cake",
"Guava Cheese Strudel",
"Chicken Croquettes",
"Guava Streudels",
"Parking",
"Guava Streudel",
"Cakes",
"Chocolate Croissant",
"Muffins",
"Sandwich",
"Pastries",
"Food",
"Turkey Croissant Sandwich",
"Steak Torta",
"Cubano Sandwich",
"Medianoche Sandwich",
"Pastrami Sandwich",
"Medianoche",
"Kisses",
"Chicken Empanadas",
"Staff",
"Wait Time",
"Coffee",
"Guava Cheese Rolls",
"Coffee Drinks",
"Cuban Fast Food",
"Cuban Snack",
"Guava & Cream Cheese",
"Almond Danish",
"Guava Cheese",
"Cream Cheese",
"Almond Dish",
"Guava/cheese Strudel",
"Cubano",
"Plantain Chips",
"Chicken Empanada",
"Mango Mousse",
"Pina Colada Dessert",
"Apple Empanada",
"Mango Empanada",
"Guava Empanada",
"Tuna Salad Croissant",
"Pan Con Bistec"
]

puts Util.cluster(strings).size
