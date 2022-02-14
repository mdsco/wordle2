class Game < ApplicationRecord
  before_validation(on: :create) do  
    self.state = {
      0 => { 0 => { "letter": 'a', "active": "played", "ci": false}, 1 => { "letter": 'a', "active": "played", "ci": false}, 2 => { "letter": 'a', "active": "played", "ci": false}, 3 => { "letter": 'a', "active": "played", "ci": false}, 4 => { "letter": 'a', "active": "played", "ci": false}, },
      1 => { 0 => { "letter": '', "active": "active", "ci": false}, 1 => { "letter": '', "active": "active", "ci": false}, 2 => { "letter": '', "active": "active", "ci": false}, 3 => { "letter": '', "active": "active", "ci": false}, 4 => { "letter": '', "active": "active", "ci": false}, },
      2 => { 0 => { "letter": '', "active": "inactive", "ci": false}, 1 => { "letter": '', "active": "inactive", "ci": false}, 2 => { "letter": '', "active": "inactive", "ci": false}, 3 => { "letter": '', "active": "inactive", "ci": false}, 4 => { "letter": '', "active": "inactive", "ci": false}, },
      3 => { 0 => { "letter": '', "active": "inactive", "ci": false}, 1 => { "letter": '', "active": "inactive", "ci": false}, 2 => { "letter": '', "active": "inactive", "ci": false}, 3 => { "letter": '', "active": "inactive", "ci": false}, 4 => { "letter": '', "active": "inactive", "ci": false}, },
      4 => { 0 => { "letter": '', "active": "inactive", "ci": false}, 1 => { "letter": '', "active": "inactive", "ci": false}, 2 => { "letter": '', "active": "inactive", "ci": false}, 3 => { "letter": '', "active": "inactive", "ci": false}, 4 => { "letter": '', "active": "inactive", "ci": false}, },
      5 => { 0 => { "letter": '', "active": "inactive", "ci": false}, 1 => { "letter": '', "active": "inactive", "ci": false}, 2 => { "letter": '', "active": "inactive", "ci": false}, 3 => { "letter": '', "active": "inactive", "ci": false}, 4 => { "letter": '', "active": "inactive", "ci": false}, }
    }

    self.keyword = "since"
  end

  def evaluate(row, col, letter)

    self.state[row][col]['letter'] = letter
    self.state[row][col]['active'] = 'played'
    if !self.state[(Integer(row)+1).to_s].nil? 
      self.state[(Integer(row)+1).to_s][col]['active'] = 'active'
    end

    pp self.state
    
    self.save!
    # mycheck = check(guess)
    # puts "Mycheck #{mycheck}"

    # if mycheck
      # puts "good job!"
    # else
      # puts "You lose!"
      # letters = intersection(guess)
      # indices = correct_indices(guess)
      # update_state(guess, letters, indices)
    # end
  end

  def check(guess)
    guess === self.keyword
  end

  def intersection(guess)
    self.state.split('').intersection(guess.split(''))
  end

  def correct_indices(guess)
    self.state.split('').each_with_index.map { |x, i| guess[i] === x }
  end

  def update_state(guess, letters, indices)

  end

end
