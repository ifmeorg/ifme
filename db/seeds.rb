# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users 
user1 = User.create(firstname: 'Test1', lastname: 'Lastname', email: 'test1@example.com', password: 'password99', location: 'Toronto, ON, Canada', timezone: '-05:00')
user2 = User.create(firstname: 'Test2', lastname: 'Lastname', email: 'test2@example.com', password: 'password99', location: 'Toronto, ON, Canada', timezone: '-05:00')

# Allies 
user1_allies = Ally.create(userid: user1.id, allies: [user2.id])
user2_allies = Ally.create(userid: user2.id, allies: [user1.id])

# User 1
user1_category1 = Category.create(userid: user1.id, name: 'Public Speaking', description: 'Speaking in front of an audience at school')
user1_mood1 = Mood.create(userid: user1.id, name: 'Anxious', description: 'Sweaty palms, increased heart rate')
user1_mood2 = Mood.create(userid: user1.id, name: 'Shy', description: 'I swallow my words and start speaking fast')
user1_trigger1 = Trigger.create!(userid: user1.id, category: Array.new(1, user1_category1.id), mood: [user1_mood1.id, user1_mood2.id], name: 'Presentation for ENGL 101', why: 'I am presenting in front of my classmates and I am worried I will make a fool out of myself', viewers: user1_allies.allies, comment: true)
user1_trigger1_comment = Comment.create(comment_type: 'trigger', commented_on: user1_trigger1.id, comment_by: user2.id, comment: "Good luck on the presentation! Just pretend everyone is in underpants :)", visibility: 'private')

# User 2
user2_category1 = Category.create(userid: user2.id, name: 'Brother', description: 'We have a strained relationship')
user2_mood1 = Mood.create(userid: user2.id, name: 'Angry', description: 'I become violent and act irrationally')
user2_trigger1 = Trigger.create(userid: user2.id, category: Array.new(1, user2_category1.id), mood: Array.new(1,user2_mood1.id), name: 'Thanksgiving Dinner', why: 'He kept asserting to everyone that I was immature and he always did everything for me.', viewers: user2_allies.allies, comment: false)
user2_trigger1_comment = Comment.create(comment_type: 'trigger', commented_on: user2_trigger1.id, comment_by: user1.id, comment: "You should talk to him one-on-one and tell him how you feel!", visibility: 'all')