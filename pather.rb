# Given an array of lines of text which contains exactly two hash (#) characters,
# replace existing characters with stars (*) to produce a path connecting
# the hash characters.  
# The vertical component of the path (if any) is drawn first, then the horizontal
# component.  The hash characters are unchanged.
class Pather

  PATH_CHAR = '*'

  def initialize(lines)
    @lines = lines.to_a
    if @lines.map { |line| line.length }.uniq.length > 1
      raise_error "Expected all lines to have the same number of characters"
    end
  end

  def draw
    update_lines
    @lines.join('')
  end

  def update_lines
    positions = hash_char_positions
    if positions.count != 2
      raise "Incorrect number of hash symbols -- expected exactly two"
    end
    start_line, start_char, end_line, end_char = *positions.flatten
    min_char, max_char = [start_char, end_char].sort
    draw_vertical(start_line, end_line, start_char)
    draw_horizontal(end_line, min_char, max_char)
    replace_endpoints(positions)
  end

  # draw the vertical portion of the path (if any)
  def draw_vertical(start_line, end_line, start_char)
    start_line.upto(end_line) do |line_idx| 
      @lines[line_idx][start_char] = PATH_CHAR 
    end
  end

  # draw the horizontal portion of the path (if any)
  def draw_horizontal(line, start_char, end_char)
    start_char.upto(end_char) { |char_idx| @lines[line][char_idx] = PATH_CHAR } 
  end

  # ensure that the endpoints are hash characters
  def replace_endpoints(positions)
    positions.each { |line_idx, char_idx| @lines[line_idx][char_idx] = '#' }
  end

  # returns an array of position subarrays, 
  # each containing a line index and a character index
  def hash_char_positions
    results = []
    (0...@lines.length).each do |line_idx|
      if @lines[line_idx].match('#')
        positions = @lines[line_idx].enum_for(:scan, /#/).each do
          results << [line_idx, Regexp.last_match.begin(0)]
        end
      end
    end
    results
  end
end

# Main script
if ARGV.length != 2
  puts "Usage: ruby pather.rb <input file> <output file>"
else
  pather = Pather.new(File.readlines(ARGV[0]))
  File.open(ARGV[1], 'w') {|f| f.write(pather.draw) }
end
