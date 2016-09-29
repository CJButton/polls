# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true

  validate :not_author_response
  validate :not_duplicate_response

  def not_own_poll
    
  end

  def not_author_response
    if self.question.poll.author_id == self.user_id
      errors[:author] << "cannot answer their own poll."
    end
  end

  def not_duplicate_response
    if sibling_responses.map(&:user_id).include?(self.user_id)
      errors[:user] << "has already answered this question."
    end
  end

  belongs_to :answer,
    primary_key: :id,
    foreign_key: :answer_id,
    class_name: :AnswerChoice

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer,
    source: :question

  def sibling_responses
    self.question.responses
      .where.not(id: self.id)#("responses.id != ?", self.id)
  end
end
