require "matrix"

class Matrix 

  def self.from_array(values)
    return Matrix.build(values.size, values[0].size) {|row, col | values[row][col].to_f }
  end
  
  def self.from_vector2(values)
    return Matrix.build(values.size, 2) {|row, col | values[row].to_a[col] }
  end

end