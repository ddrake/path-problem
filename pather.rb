# Given an array of lines of text which contains exactly two hash (#) characters,
# replace existing characters with stars (*) to produce a path connecting
# the hash characters.  
# The vertical component of the path (if any) is drawn first, then the horizontal
# component.  The hash characters are unchanged.
class Pather

  PATH_CHAR = '*'

  def initialize(lines)
    @lines = lines.to_a
  end

  def draw
    update_lines
    @lines.join('')
  end

  def update_lines
    line_info = lines_containing_hash_chars.flatten
    if line_info.count == 3
      # hash characters are on the same line
      start_line, start_char, end_char = *line_info
      end_line = start_line
    elsif line_info.count == 4 && lines_containing_hash_chars.count == 2
      # hash characters are on different lines
      start_line, start_char, end_line, end_char = *line_info
    else
      raise "Incorrect number of hash symbols.  Expected exactly two."
    end
    l_to_r = start_char <= end_char
    skip_first = line_info.count == 3
    draw_vertical(start_line, end_line, start_char)
    draw_horizontal(start_char, end_char, end_line, l_to_r, skip_first)
  end

  # draw the vertical portion of the path (if any)
  def draw_vertical(start_line, end_line, start_char)
    (start_line + 1).upto(end_line - 1) do |line_idx| 
      @lines[line_idx][start_char] = PATH_CHAR 
    end
  end

  # draw the horizontal portion of the path (if any)
  def draw_horizontal(start_char, end_char, end_line, l_to_r, skip_first)
    proc = Proc.new { |char_idx| @lines[end_line][char_idx] = PATH_CHAR }
    if l_to_r
      start_char = skip_first ? start_char + 1 : start_char
      start_char.upto(end_char - 1, &proc) 
    else
      start_char.downto(end_char + 1, &proc)
    end
  end

  # returns an array of line_info subarrays, each containing a row index
  # and an array of indices of hash characters
  def lines_containing_hash_chars
    results = []
    (0...@lines.length).each do |line_idx| 
      if @lines[line_idx].match('#')
        positions = @lines[line_idx].enum_for(:scan, /#/).map do 
          Regexp.last_match.begin(0) 
        end
        results << [line_idx, positions] if positions.length > 0
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
