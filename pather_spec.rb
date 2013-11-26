require 'rspec'
require './pather.rb'

describe Pather do
  describe "with the provided sample input" do
    it "should match the expected output" do
      @input = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ....#...................
        ........................
        ........................
        ........................
        ........................
        ..................#.....
        ........................
        ........................
        ........................
        ........................
      EOS
      @expected = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ....#...................
        ....*...................
        ....*...................
        ....*...................
        ....*...................
        ....**************#.....
        ........................
        ........................
        ........................
        ........................
      EOS
      expect(Pather.new(@input.lines).draw).to eq @expected
    end
  end
  describe "with the hash character positions reversed" do
    it "should match the expected output" do
      @input = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ..................#.....
        ........................
        ........................
        ........................
        ........................
        ....#...................
        ........................
      EOS
      @expected = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ..................#.....
        ..................*.....
        ..................*.....
        ..................*.....
        ..................*.....
        ....#**************.....
        ........................
      EOS
      expect(Pather.new(@input.lines).draw).to eq @expected
    end
  end
  describe "with only one line difference" do
    it "should match the expected output" do
      @input = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ....#...................
        ..................#.....
        ........................
      EOS
      @expected = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ....#...................
        ....**************#.....
        ........................
      EOS
      expect(Pather.new(@input.lines).draw).to eq @expected
    end
  end
  describe "with only one line difference reversed" do
    it "should match the expected output" do
      @input = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ..................#.....
        ....#...................
        ........................
      EOS
      @expected = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ..................#.....
        ....#**************.....
        ........................
      EOS
      expect(Pather.new(@input.lines).draw).to eq @expected
    end
  end
  describe "with hashes in the same line" do
    it "should match the expected output" do
      @input = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ....#.............#.....
        ........................
      EOS
      @expected = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ....#*************#.....
        ........................
      EOS
      expect(Pather.new(@input.lines).draw).to eq @expected
    end
  end
  describe "with hashes in the same column" do
    it "should match the expected output" do
      @input = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ....#...................
        ........................
        ....#...................
        ........................
      EOS
      @expected = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ....#...................
        ....*...................
        ....#...................
        ........................
      EOS
      expect(Pather.new(@input.lines).draw).to eq @expected
    end
  end
  describe "with adjacent hashes in the same line" do
    it "should match the expected output" do
      @input = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ....##..................
        ........................
      EOS
      @expected = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ........................
        ....##..................
        ........................
      EOS
      expect(Pather.new(@input.lines).draw).to eq @expected
    end
  end
  describe "with adjacent hashes in the same column" do
    it "should match the expected output" do
      @input = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ....#...................
        ....#...................
        ........................
      EOS
      @expected = <<-EOS.gsub(/^ {8}/, '')
        ........................
        ....#...................
        ....#...................
        ........................
      EOS
      expect(Pather.new(@input.lines).draw).to eq @expected
    end
  end
end
