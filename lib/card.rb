class Card
  attr_reader :rank, :suit
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def is_face_card?
    ['J', 'Q', 'K', 'A'].include?(@rank)
  end

  def is_ace?
    ('A').include?(@rank)
  end
end
