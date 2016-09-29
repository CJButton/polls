# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :uniqueness => true, presence: true

  has_many :polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  def completed_polls_sql
    #results = ActiveRecord::Base.connection.execute(<<-SQL)
    results = Poll.find_by_sql(<<-SQL)
      SELECT
        polls.*
      FROM
        users JOIN polls
          ON users.id = polls.author_id
        JOIN questions
          ON polls.id = questions.poll_id
        JOIN answer_choices
          ON answer_choices.question_id = questions.id
        JOIN responses
          ON responses.answer_id = answer_choices.id
      WHERE
        responses.user_id = #{self.id}
      GROUP BY
        polls.id
      HAVING
        COUNT(responses.user_id) > 0
    SQL

    results.map do |result|
      result
    end
  end

  def completed_polls
    results = Poll.joins(:questions => :responses)
      .where("responses.user_id = ?", self.id)
      .group("polls.id")
      .having("COUNT(responses.user_id) > 0")

    results.map do |result|
      result
    end
  end
end
