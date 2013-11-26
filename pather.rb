class Pather

  STAR = '*'
  HASH = '#'

  def initialize(lines)
    @lines = lines
  end

  def with_path
    draw_path
    @lines.join('')
  end

  def draw_path
    start_line, start_char, end_line, end_char = *hash_positions
    end_line, end_char = start_line, start_char unless end_line
    left_to_right = start_char <= end_char
    draw_vertical(start_line, end_line, start_char)
    draw_horizontal(start_char, end_char, end_line, left_to_right)
  end

  def draw_vertical(start_line, end_line, start_char)
    (start_line + 1).upto(end_line - 1) { |line_idx| @lines[line_idx][start_char] = STAR }
  end

  def draw_horizontal(start_char, end_char, end_line, left_to_right, &block)
    if left_to_right
      start_char.upto(end_char - 1) { |char_idx| @lines[end_line][char_idx] = STAR }
    else
      start_char.downto(end_char + 1) { |char_idx| @lines[end_line][char_idx] = STAR }
    end
  end

  def hash_positions
    @lines.map.with_index { |line, idx| 
      hash_pos = line.index(HASH)
      hash_pos ? [idx, line.index(HASH)] : nil 
    }.compact.flatten
  end
end

if ARGV.length != 2
  puts "Usage: ruby pather.rb <input file> <output file>"
else
  pather = Pather.new(File.readlines(ARGV[0]))
  File.open(ARGV[1], 'w') {|f| f.write(pather.with_path) }
end
