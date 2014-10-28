class Triangle
  attr_accessor :side1, :side2, :side3

  SHAPE_DESC = {
    equilateral: "equilateral!",
    isosceles: "isosceles! Also, that word is hard to type.",
    scalene: "scalene and mathematically boring.",
  }

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral?
    (side1 == side2) && (side2 == side3)
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def scalene?
    true unless equilateral? || isosceles?
  end

  def triangle_shape_desc
    return :equilateral if equilateral?
    return :isosceles if isosceles?
    return :scalene if scalene?
  end

  def recite_facts()
    print "This triangle: #{ object_id }, with sides #{ @side1 } #{ @side2 } #{ @side3 }, "
    print "is #{ SHAPE_DESC[triangle_shape_desc] } "
    print "The angles are #{ angles_from_sides.join(', ') }. "
    print "This triangle is also a right triangle!" if angles_from_sides.include? 90
    print "\n\n"
  end

  def rads_to_deg(rads)
    (rads * 180 / Math::PI).round
  end

  private

  def angles_from_sides
    positions = [[side3, side2, side1],
                 [side1, side3, side2],
                 [side1, side2, side3]]
    angles = [0, 0, 0]

    positions.each_with_index do |position, index|
      angles[index] = law_of_cosines(position)
    end
    angles
  end

  # length[0] != @side1
  def law_of_cosines(length)
    rads_to_deg(Math.acos((length[0]**2 + length[1]**2 - length[2]**2) / (2.0 * length[0] * length[1])))
  end
end

triangles = [[5, 5, 5], [5, 12, 13]]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
  print "Let's change side 1 to 4in.. "
  tri.side1 = 4
  tri.recite_facts
end
