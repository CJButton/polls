# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer          not null
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  def results
    query_results = self.answers.joins(:responses)
      .select("answer_choices.text, COUNT(*) AS response_count")
      .group("answer_choices.text, answer_choices.id")

    results_hash = {}
    query_results.each do |result|
      results_hash[result.text] = result.response_count
    end
    results_hash
  end

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answers,
  primary_key: :id,
  foreign_key: :question_id,
  class_name: :AnswerChoice

  has_many :responses,
    through: :answers,
    source: :responses
end
