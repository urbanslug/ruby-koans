require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

class Greed < Array
	
	def initialize(dice)
		@dice = dice
	end

	def compute_score
		case
		
		when @dice.size == 0
			return 0

		when @dice.size == 1
			return 100 if @dice[0] == 1
                        return 50  if @dice[0] == 5
			return 0

		when @dice.size == 2
			return 200 if @dice.uniq[0] == 1 && @dice.uniq.size == 1
			return 100 if @dice.uniq[0] == 5 && @dice.uniq.size == 1
			return 0

		when @dice.size == 3
			return 1000 if @dice.uniq[0] == 1 && @dice.uniq.size == 1
			return 100 * (@dice.uniq[0]) if @dice.uniq.size == 1
			return 0

		when @dice.size == 4 || @dice.size == 5
			return for4n5
		end
	end

	def for4n5

		preliminary_score = 0

		if @dice.uniq.size > 3
			preliminary_score += @dice.count(1)*100 if @dice.count(1)>3
			preliminary_score += 1000 if  @dice.count(1) >= 3
			preliminary_score += 200  if  @dice.count(2) == 3
			preliminary_score += 300  if  @dice.count(3) == 3
			preliminary_score += 400  if  @dice.count(4) == 3
			preliminary_score += 500  if  @dice.count(5) >= 3
			preliminary_score += 600  if  @dice.count(6) == 3
			preliminary_score += (@dice.count(5)-3)*50  if @dice.count(5)>3
			preliminary_score += @dice.count(5)*50 if @dice.count(5) < 3
			preliminary_score += (@dice.count(1)-3)*100 if @dice.count(1)>3
			return preliminary_score
		else
    		        preliminary_score += @dice.count(1)*100 if @dice.count(1) < 3
		        preliminary_score += 1000 if @dice.count(1) >= 3
			preliminary_score += 200 if  @dice.count(2) == 3
		        preliminary_score += 300 if  @dice.count(3) == 3
		        preliminary_score += 400 if  @dice.count(4) == 3
			preliminary_score += 500 if  @dice.count(5) >= 3
		        preliminary_score += 600 if  @dice.count(6) == 3
			preliminary_score += (@dice.count(5)-3)*50 if @dice.count(5) > 3
			preliminary_score += @dice.count(5)*50 if @dice.count(5) < 3
			preliminary_score += (@dice.count(1)-3)*100 if @dice.count(1)>3

			return preliminary_score
		end

		return preliminary_score
	end
end


def score(dice)
	current_dice_roll = Greed.new(dice)

	score = current_dice_roll.compute_score
	return score
  # You need to write this method
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
