# Dice class can have N number of faces
class Dice
  def initialize(faces = [])
    @faces = faces.any? || (1..6).to_a
  end

  def rolls
    rand(1..@faces.size)
  end
end