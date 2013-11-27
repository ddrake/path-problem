# Pather

Given a text file 'input.txt' with a rectangular block of dot
characters ('.') and exactly two hash characters ('#'), the program 'pather'
writes out to 'output.txt' the same data with the two '#' characters
joined by asterisks ('*'). The command is invoked like this:

  pather input.txt output.txt

The file 'pather' needs to be executable (chmod +x pather).

The rules for the path:

* No diagonals.
* Only change direction once.
* Start with a vertical line and then complete with a horizontal line.

## Dependencies

In addition to Bash, this implementation assumes that Ruby 1.8 or higher is installed on the target machine.
Some additional specs are provided in pather_spec.rb.  The Rspec gem is required to execute these specs.
Install it if necessary via `gem install rspec` 
Then run specs like this: `rspec pather_spec.rb`
