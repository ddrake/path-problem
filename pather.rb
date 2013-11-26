# Given an array of lines of text which contains exactly two hash (#) characters
# replace existing characters with stars (*) to produce a path connecting
# the hash characters.  
# The vertical component of the path (if any) is drawn first, then the horizontal
# component.  The hash characters are unchanged.
class Pather

  PATH_CHAR = '*'

  def initialize(lines)
    @lines = lines
  end

  def with_path
    draw_path
    @lines.join('')
  end

  def draw_path
    line_info = lines_containing_hash_chars.flatten

    if line_info.count == 3
      # hash characters are on the same line
      start_line, start_char, end_char = *line_info
      end_line = start_line
    elsif line_info.count == 4
      # hash characters are on different lines
      start_line, start_char, end_line, end_char = *line_info
    else
      raise "File contains an incorrect number of hash symbols.  Expected exactly two."
    end
    left_to_right = start_char <= end_char
    draw_vertical(start_line, end_line, start_char)
    draw_horizontal(start_char, end_char, end_line, left_to_right, line_info.count == 3)
  end

  def draw_vertical(start_line, end_line, start_char)
    (start_line + 1).upto(end_line - 1) { |line_idx| @lines[line_idx][start_char] = PATH_CHAR }
  end

  def draw_horizontal(start_char, end_char, end_line, left_to_right, skip_first_char)
    if left_to_right
      start_char = skip_first_char ? start_char + 1 : start_char
      start_char.upto(end_char - 1) { |char_idx| @lines[end_line][char_idx] = PATH_CHAR }
    else
      start_char.downto(end_char + 1) { |char_idx| @lines[end_line][char_idx] = PATH_CHAR }
    end
  end

  # returns an array of line_info subarrays, each containing a row index
  # and an array of indices of hash characters
  def lines_containing_hash_chars
    results = []
    @lines.each_index do |line_idx| 
      if @lines[line_idx].match('#')
        positions = @lines[line_idx].enum_for(:scan, /#/).map { Regexp.last_match.begin(0) }
        results << [line_idx, positions] if positions.length > 0
      end
    end
    results
  end
end

if ARGV.length != 2
  puts "Usage: ruby pather.rb <input file> <output file>"
else
  pather = Pather.new(File.readlines(ARGV[0]))
  File.open(ARGV[1], 'w') {|f| f.write(pather.with_path) }
end
