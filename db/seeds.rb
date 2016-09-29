# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(username: "Smithee")
User.create(username: "Bob")

Poll.create(title: "Who?", author_id: 1)
Poll.create(title: "Why?", author_id: 2)

Question.create(text: "Who is he?", poll_id: 1)
Question.create(text: "Who isn't he?", poll_id: 1)
Question.create(text: "Why not?", poll_id: 2)

AnswerChoice.create(text: "bob", question_id: 1)
AnswerChoice.create(text: "Cheryl", question_id: 1)
AnswerChoice.create(text: "Me", question_id: 2)
AnswerChoice.create(text: "You", question_id: 2)
AnswerChoice.create(text: "Because", question_id: 3)
AnswerChoice.create(text: "Oh, go away", question_id: 3)

Response.create(user_id: 2, answer_id: 1)
Response.create(user_id: 2, answer_id: 3)
Response.create(user_id: 1, answer_id: 6)
