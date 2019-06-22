class Move < ApplicationRecord
  belongs_to :game

  belongs_to :player

  validates :x,
    inclusion: { in: 0..2, message: "must be between 0 and 2" },
    presence: true

  validates :y,
    inclusion: { in: 0..2, message: "must be between 0 and 2" },
    presence: true

  validate :game_is_not_finished

  # Make moves immutable
  def readonly?
    !new_record?
  end

  def game_is_not_finished
    if self.game.is_finished?
      errors.add(:game, "game is finished")
    end
  end
end

