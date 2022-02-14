class Game < ApplicationRecord
  before_validation(on: :create) do  
    self.state = {
      0 => { 0 => { "letter": '', "active": "active", "color": "white"}, 1 => { "letter": '', "active": "active", "color": "white"}, 2 => { "letter": '', "active": "active", "color": "white"}, 3 => { "letter": '', "active": "active", "color": "white"}, 4 => { "letter": '', "active": "active", "color": "white"}, },
      1 => { 0 => { "letter": '', "active": "inactive", "color": "white"}, 1 => { "letter": '', "active": "inactive", "color": "white"}, 2 => { "letter": '', "active": "inactive", "color": "white"}, 3 => { "letter": '', "active": "inactive", "color": "white"}, 4 => { "letter": '', "active": "inactive", "color": "white"}, },
      2 => { 0 => { "letter": '', "active": "inactive", "color": "white"}, 1 => { "letter": '', "active": "inactive", "color": "white"}, 2 => { "letter": '', "active": "inactive", "color": "white"}, 3 => { "letter": '', "active": "inactive", "color": "white"}, 4 => { "letter": '', "active": "inactive", "color": "white"}, },
      3 => { 0 => { "letter": '', "active": "inactive", "color": "white"}, 1 => { "letter": '', "active": "inactive", "color": "white"}, 2 => { "letter": '', "active": "inactive", "color": "white"}, 3 => { "letter": '', "active": "inactive", "color": "white"}, 4 => { "letter": '', "active": "inactive", "color": "white"}, },
      4 => { 0 => { "letter": '', "active": "inactive", "color": "white"}, 1 => { "letter": '', "active": "inactive", "color": "white"}, 2 => { "letter": '', "active": "inactive", "color": "white"}, 3 => { "letter": '', "active": "inactive", "color": "white"}, 4 => { "letter": '', "active": "inactive", "color": "white"}, },
      5 => { 0 => { "letter": '', "active": "inactive", "color": "white"}, 1 => { "letter": '', "active": "inactive", "color": "white"}, 2 => { "letter": '', "active": "inactive", "color": "white"}, 3 => { "letter": '', "active": "inactive", "color": "white"}, 4 => { "letter": '', "active": "inactive", "color": "white"}, }
    }

    self.keyword = "since"
  end

  def update(row, col, letter)
    self.state[row][col]['letter'] = letter
    self.state[row][col]['active'] = 'played'
    if !self.state[(Integer(row)+1).to_s].nil? 
      self.state[(Integer(row)+1).to_s][col]['active'] = 'active'
    end
    
    self.save!
  end

  def evaluate(row)
    test_word = word_from_state(row)
    if test_word
      # colors set to green and win state set?
    else
      # get intersection and set relevant cells to yellow
      # get correct indices and set relevant cells to green

    end

    # puts "Correct? #{check(test_word)}"
    # puts "Intersection: #{intersection(test_word)}"

    assign_color(row, test_word.split(''))

    self.save!
  end

  def assign_color(row, test_word)
    colors = Array.new(5)
    keywordArr = self.keyword.split('')

    test_word.each_with_index do |value, i|
      if value == keywordArr[i]
        self.state[row][i.to_s]['color'] = 'green'
        colors[i] = 'green'
      elsif !(value == keywordArr[i]) && keywordArr.include?(value)
        self.state[row][i.to_s]['color'] = 'yellow'
        colors[i] = 'yellow'
      else
        self.state[row][i.to_s]['color'] = 'gray'
        colors[i] = 'gray'
      end
    end

    pp self.state[row] 

  end

  def word_from_state(row)
    char = ''
    self.state[row].each do |k, v|
      char = char + v['letter'].downcase
    end
    puts char
    char
  end

  def check(word)
    word === self.keyword
  end

  # def intersection(guess)
  #   self.keyword.split('').intersection(guess.split(''))
  # end

  # def correct_indices(guess)
  #   self.state.split('').each_with_index.map { |x, i| guess[i] === x }
  # end

end
