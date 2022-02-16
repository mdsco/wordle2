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

    self.keyword = "since"

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

    test_word.each_with_index do |value, i|
      if value == keywordArr[i]
        self.state[row][i.to_s]['color'] = 'green'
      elsif !(value == keywordArr[i]) && keywordArr.include?(value)
        self.state[row][i.to_s]['color'] = 'yellow'
      else
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

end
