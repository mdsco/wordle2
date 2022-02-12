class Game < ApplicationRecord
  before_validation(on: :create) do  
    self.state = {
      0 => { 0 => { "letter": 'a', "cl": false, "ci": false}, 1 => { "letter": 'a', "cl": false, "ci": false}, 2 => { "letter": 'a', "cl": false, "ci": false}, 3 => { "letter": 'a', "cl": false, "ci": false}, 4 => { "letter": 'a', "cl": false, "ci": false}, },
      1 => { 0 => { "letter": '', "cl": false, "ci": false}, 1 => { "letter": '', "cl": false, "ci": false}, 2 => { "letter": '', "cl": false, "ci": false}, 3 => { "letter": '', "cl": false, "ci": false}, 4 => { "letter": '', "cl": false, "ci": false}, },
      2 => { 0 => { "letter": '', "cl": false, "ci": false}, 1 => { "letter": '', "cl": false, "ci": false}, 2 => { "letter": '', "cl": false, "ci": false}, 3 => { "letter": '', "cl": false, "ci": false}, 4 => { "letter": '', "cl": false, "ci": false}, },
      3 => { 0 => { "letter": '', "cl": false, "ci": false}, 1 => { "letter": '', "cl": false, "ci": false}, 2 => { "letter": '', "cl": false, "ci": false}, 3 => { "letter": '', "cl": false, "ci": false}, 4 => { "letter": '', "cl": false, "ci": false}, },
      4 => { 0 => { "letter": '', "cl": false, "ci": false}, 1 => { "letter": '', "cl": false, "ci": false}, 2 => { "letter": '', "cl": false, "ci": false}, 3 => { "letter": '', "cl": false, "ci": false}, 4 => { "letter": '', "cl": false, "ci": false}, },
      5 => { 0 => { "letter": '', "cl": false, "ci": false}, 1 => { "letter": '', "cl": false, "ci": false}, 2 => { "letter": '', "cl": false, "ci": false}, 3 => { "letter": '', "cl": false, "ci": false}, 4 => { "letter": '', "cl": false, "ci": false}, }
    }

    self.keyword = "since"
  end

  def evaluate(guess)
    mycheck = check(guess)
    puts "Mycheck #{mycheck}"

    if mycheck
      puts "good job!"
    else
      puts "You lose!"
      # letters = intersection(guess)
      # indices = correct_indices(guess)
      # update_state(guess, letters, indices)
    end
  end

  def [](row, col)
    result = state[row.to_s][col.to_s]
    puts "Result #{result.nil?}"
    result
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
