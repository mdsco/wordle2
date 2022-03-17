class Game < ApplicationRecord
  before_validation(on: :create) do  
    self.state = {
      0 => { 0 => { "letter": '', "active": "active", "color": "white"}, 
             1 => { "letter": '', "active": "active", "color": "white"}, 
             2 => { "letter": '', "active": "active", "color": "white"}, 
             3 => { "letter": '', "active": "active", "color": "white"}, 
             4 => { "letter": '', "active": "active", "color": "white"}, },
      1 => { 0 => { "letter": '', "active": "inactive", "color": "white"}, 
             1 => { "letter": '', "active": "inactive", "color": "white"}, 
             2 => { "letter": '', "active": "inactive", "color": "white"}, 
             3 => { "letter": '', "active": "inactive", "color": "white"}, 
             4 => { "letter": '', "active": "inactive", "color": "white"}, },
      2 => { 0 => { "letter": '', "active": "inactive", "color": "white"}, 
             1 => { "letter": '', "active": "inactive", "color": "white"}, 
             2 => { "letter": '', "active": "inactive", "color": "white"}, 
             3 => { "letter": '', "active": "inactive", "color": "white"}, 
             4 => { "letter": '', "active": "inactive", "color": "white"}, },
      3 => { 0 => { "letter": '', "active": "inactive", "color": "white"}, 
             1 => { "letter": '', "active": "inactive", "color": "white"}, 
             2 => { "letter": '', "active": "inactive", "color": "white"}, 
             3 => { "letter": '', "active": "inactive", "color": "white"}, 
             4 => { "letter": '', "active": "inactive", "color": "white"}, },
      4 => { 0 => { "letter": '', "active": "inactive", "color": "white"}, 
             1 => { "letter": '', "active": "inactive", "color": "white"}, 
             2 => { "letter": '', "active": "inactive", "color": "white"}, 
             3 => { "letter": '', "active": "inactive", "color": "white"}, 
             4 => { "letter": '', "active": "inactive", "color": "white"}, },
      5 => { 0 => { "letter": '', "active": "inactive", "color": "white"}, 
             1 => { "letter": '', "active": "inactive", "color": "white"}, 
             2 => { "letter": '', "active": "inactive", "color": "white"}, 
             3 => { "letter": '', "active": "inactive", "color": "white"}, 
             4 => { "letter": '', "active": "inactive", "color": "white"}, }
    }

    self.keyword = GamesHelper::WORDLIST.sample
    self.winstate = ''
  end

  after_update_commit { broadcast_update }

  def update(row, col, letter)
    self.state[row][col]['letter'] = letter
    self.state[row][col]['active'] = 'played'
    if !self.state[(Integer(row)+1).to_s].nil? 
      self.state[(Integer(row)+1).to_s][col]['active'] = 'active'
    end
    
    self.save!
  end

  def update_letter(row, col, letter)
    cell = self.state[row][col]
    cell['letter'] = letter
    cell['color'] = "black"

    intcol = col.to_i
    nextcol = (intcol + 1).to_s

    if (col.to_i <= self.state[row].length - 2)
      self.state[row][col]['focus'] = false 
      self.state[row][nextcol]['focus'] = true
    end
    
    self.save!
  end

  def evaluate(row)

    test_word = word_from_state(row)

    assign_color(row, test_word.split(''))

    if check(test_word) && Integer(row) < self.state.length
      self.winstate = "win"
    elsif !check(test_word) && Integer(row) == self.state.length - 1
      self.winstate = "lose"
    end

    self.save!
  end

  def assign_color(row, test_word)
    keywordArr = self.keyword.split('')

    letters = map_letters(self.keyword)

    test_word.each_with_index do |value, i|
      if value == keywordArr[i]
        self.state[row][i.to_s]['color'] = 'green'
        if letters[value] > 0
          letters[value] -= 1
        end
      end
    end

    test_word.each_with_index do |value, i|
      if keywordArr.include?(value) && letters[value] > 0
        if self.state[row][i.to_s]['color'] != 'green'
          self.state[row][i.to_s]['color'] = 'yellow'
        end
        if letters[value] > 0
          letters[value] -= 1
        end
      elsif self.state[row][i.to_s]['color'] != 'green'
        self.state[row][i.to_s]['color'] = 'gray'
      end
    end

  end

  def word_from_state(row)
    char = ''
    self.state[row].each do |k, v|
      char = char + v['letter'].downcase
    end
    char
  end

  def check(word)
    word == self.keyword
  end

  def map_letters(s)
    Hash[s.split('').group_by{ |c| c }.map{ |k, v| [k, v.size] }]
  end

end


