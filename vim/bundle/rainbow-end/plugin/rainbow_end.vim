" ============================================================================
" File:        rainbow_end.vim
" Description: vim plugin to rainbow highligh ruby block keywords
" Maintainer:  Michael Nussbaum <michaelnussbaum08@gmail.com>
" License:     GPLv2+
" Version:     0.1.1
"
" ============================================================================


if exists("g:rainbow_end_loaded") || !has("ruby")
    finish
endif


function! ToggleRainbow()
ruby << EOF
  toggle_rainbow()
EOF
endfunction

function! RainbowOff()
ruby << EOF
  toggle_rainbow(turn_off = true)
EOF
endfunction

autocmd InsertEnter * :call RainbowOff()


ruby << EOF

# TODO: find and highlight middle elements of blocks (else, rescue, etc.)
# TODO: detect text changes, if none then reuse found blocks

@rainbow_on = false


def toggle_rainbow(turn_off = @rainbow_on)
  #
  # Toggles rainbow highlighting of Ruby block opening/closing keywords
  #
  if turn_off
    Vim.command("call clearmatches()")
  else
    block_finder = BlockFinder.new
    highlighter = BlockHighlighter.new(block_finder.blocks)
    highlighter.color
  end
  @rainbow_on = !turn_off
end


class BlockHighlighter
  #
  # Highlights opening/closing keywords of Ruby blocks using colors listed
  # in COLORS hash below.
  #
  COLORS = {:RED => 196, :ORANGE => 208, :YELLOW => 226, :GREEN => 10,
            :BLUE => 81, :PINK => 200}

  def initialize(blocks)
    #
    # blocks is a list of lists each containing two hashes, the first hash
    # representing the location of a block opener keyword and the second a
    # block closer keyword. Each hash has a  =>line, a number, and a :char_range.
    # :char_range is a list of two integers representing the start and end
    # indices of the keyword.
    #
    @blocks = blocks
  end

  def color()
    # cycle through all available colors
    colors = COLORS.keys
    color_counter = 0
    @blocks.each do |beginning, ending|
      color = colors[color_counter]
      color_code = COLORS[color]
      # loop counter back to zero if end reachead
      if color_counter + 1 == colors.size
        color_counter = 0
      else
        color_counter += 1
      end
      # the vim color group must be declared before it can be used
      _make_color_group(color, color_code)
      _highlight_word(color, beginning)
      _highlight_word(color, ending)
    end
  end

  def _make_color_group(name, color_code)
    VIM.command("highlight #{name} ctermfg=#{color_code}")
  end

  def _highlight_word(color_group, word_location)
    #
    # color_group is the string name of a declared color group.
    # word_location is a hash with a :line number and the :char_range start and
    # end indices of a word to highlight.
    #
    if word_location.empty?
      return
    end
    line = word_location[:line]
    start_column = word_location[:char_range][0] + 1
    end_column = word_location[:char_range][1] + 1
    match_location = "\\(\\%#{line}l\\&\\%#{start_column}v.*\\%#{end_column}v\\)"
    matchadd_command = "call matchadd(\"#{color_group}\", '#{match_location}')"
    Vim.command(matchadd_command)
  end
end


class BlockFinder
  #
  # Finds ruby blocks. The blocks variable holds a list of two element arrays,
  # each array containing the location of the beginning and ending keywords of
  # a block. The location info is a hash containing a :line number and a
  # :char_range. :char_range is a two integer array with the beginning and
  # ending indices of the found keyword.
  #
  attr_reader :blocks

  START_OF_LINE_BEGINNINGS = ['if', 'unless', 'while', 'until']
  ANYWHERE_BEGINNINGS = ['module', 'class', 'def', 'case', 'begin', 'do']

  def initialize()
    @blocks = []
    beginnings, endings = _find_beginnings_and_endings
    _find_blocks(beginnings, endings)
  end

  def _find_beginnings_and_endings()
    #
    # Returns two arrays, the group of found beginning keywords and the group
    # of found ending keywords.
    #
    end_lines = []
    beginning_lines = []
    current_buffer = Vim::Buffer.current
    1.upto(current_buffer.count) do |line_num|
      line = current_buffer[line_num]
      # These keywords only open a block at the beginning of a line
      beginning_matches = START_OF_LINE_BEGINNINGS.map do |beginning|
        line.match(/^[ ]*#{beginning}([ ]+|$)/)
      end
      # These keywords always open a block
      anywhere_beginning_matches = ANYWHERE_BEGINNINGS.map do |beginning|
        line.match(/(^|[ ]+)#{beginning}([ ]+|$)/)
      end
      beginning_matches.concat(anywhere_beginning_matches)
      end_match = line.match(/(^|[ ]+)end/)
      # match_group is set to either beginning_lines or end_lines depending on
      # the type of keyword found.
      # match_range is a two integer array indicating the beginning and ending
      # indices of the found keyword.
      if end_match
        match_range = end_match.offset(0)
        match_group = end_lines
      elsif beginning_matches.any?
        # There should only be one beginning per line
        found_beginning = beginning_matches.compact.first
        match_range = found_beginning.offset(0)
        match_group = beginning_lines
      end
      # make sure that if a keyword is found it isn't behind a comment
      if match_range
        hash_match = line.match("#")
        if not hash_match or (hash_match and
            hash_match.offset(0)[0] > match_range[0])
          match_group << {:line => line_num, :char_range => match_range}
        end
      end
    end
    return beginning_lines, end_lines
  end

  def _find_blocks(beginnings, ends)
    #
    # Associates every ending keyword with a beginning keyword, puts the
    # matched pairs in an array and then into the @blocks var. Ends are matched
    # to beginnings, not beginnings matched to ends.
    #
    # Sort beginnings by line number so the hi lowest beginning line that is
    # still above the end line we are trying to pair off is selected first.
    beginnings.sort!{ |match1, match2| match1[:line] <=> match2[:line] }.reverse!
    ends.each do |ending|
      # beginning_match is the first block opening keyword above the ending
      # keyword we are currently trying to pair off.
      beginning_match = beginnings.select do |beginning|
        break beginning if beginning[:line] < ending[:line]
      end || {}
      # beginnings are removed as they're paired off with endings
      beginnings.delete(beginning_match)
      @blocks << [beginning_match, ending]
    end
  end
end
EOF

let g:rainbow_end_loaded = 1

