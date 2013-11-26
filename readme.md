# Pather

Given that the text file 'input.txt' contains a rectangular block of dot
characters ('.') and exactly two hash characters ('#'), write a program 'pather'
which writes out to 'output.txt' the same data with the two '#' characters
joined by asterisks ('*'). The command will be invoked like this:

  pather input.txt output.txt

Your job is to implement 'pather' in this directory. This script will run it
for you and test the accuracy of the output. The file 'pather' will need to
be executable (chmod +x pather).

The rules for the path:

* No diagonals.
* Only change direction once.
* Start with a vertical line and then complete with a horizontal line.

## Dependencies

In addition to Bash, this implementation assumes that Ruby 1.8 or higher is installed on the target machine.
Some additional specs are provided in pather_spec.rb.  The Rspec gem is required to execute these specs.
