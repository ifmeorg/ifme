# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
user1 = User.create(name: 'Test1 Lastname', email: 'test1@example.com', password: 'passworD@99', location: 'Toronto, ON, Canada', about: 'Hi my name is Test1! I want to use the site so that I can improve the way I handle my anxiety.')
user2 = User.create(name: 'Test2 Lastname', email: 'test2@example.com', password: 'passworD@99', location: 'Toronto, ON, Canada')
user3 = User.create(name: 'Test3 Two-Lastnames', email: 'test3@example.com', password: 'passworD@99', location: 'San Francisco, CA, United States')
user4 = User.create(name: 'Admin User', email: 'admin@example.com', password: 'passworD@99', location: 'San Francisco, CA, United States', admin: true)

# Allies
Allyship.create(user_id: user1.id, ally_id: user2.id, status: :accepted)
Allyship.create(user_id: user2.id, ally_id: user1.id, status: :accepted)
Allyship.create(user_id: user1.id, ally_id: user3.id, status: :accepted)
Allyship.create(user_id: user3.id, ally_id: user1.id, status: :accepted)
Allyship.create(user_id: user2.id, ally_id: user3.id, status: :pending_from_user)

# User 1
user1_category1 = Category.create(user_id: user1.id, name: 'Public Speaking', description: 'Speaking in front of an audience at school')
user1_mood1 = Mood.create(user_id: user1.id, name: 'Anxious', description: 'Sweaty palms, increased heart rate')
user1_mood2 = Mood.create(user_id: user1.id, name: 'Shy', description: 'I swallow my words and start speaking fast')
user1_moment1 = Moment.create(user_id: user1.id, category: Array.new(1, user1_category1.id), mood: [user1_mood1.id, user1_mood2.id], name: 'Presentation for ENGL 101', why: 'I am presenting in front of my classmates and I am worried I will make a fool out of myself', viewers: [user2.id, user3.id], comment: true)
user1_moment1_comment = Comment.create(commentable_type: 'moment', commentable_id: user1_moment1.id, comment_by: user2.id, comment: "Good luck on the presentation! Just pretend everyone is in underpants :)", visibility: 'private')
user1_group1 = Group.create(name: 'Students with Anxiety', description: 'A support group for students to discuss anxiety weekly')
user1_group1_member1 = GroupMember.create(group_id: user1_group1.id, user_id: user1.id, leader: true)
user1_meeting1 = Meeting.create(name: 'Meeting #1: Self-care', description: 'This week we will be talking about what we can do to adequately self-care during exams', location: 'http://SomeGoogleHangoutURL', time: '6:00 pm EST', maxmembers: 5, group_id: user1_group1.id)
user1_meeting1_member1 = MeetingMember.create(meeting_id: user1_meeting1.id, user_id: user1.id, leader: true)
user1_meeting2 = Meeting.create(name: 'Meeting #2: Exposure', description: 'This week we will be talking about how to expose ourselves to stressors', location: '1 Yonge St, Toronto, Canada', time: '6:00 pm EST', maxmembers: 0, group_id: user1_group1.id)
user1_meeting2_member1 = MeetingMember.create(meeting_id: user1_meeting2.id, user_id: user1.id, leader: true)
user1_group2 = Group.create(name: 'Depression Discussion Group', description: 'A support group for people with depression')
user1_group2_member1 = GroupMember.create(group_id: user1_group2.id, user_id: user1.id, leader: true)

# User 2
user2_category1 = Category.create(user_id: user2.id, name: 'Brother', description: 'We have a strained relationship')
user2_mood1 = Mood.create(user_id: user2.id, name: 'Angry', description: 'I become violent and act irrationally')
user2_mood2 = Mood.create(user_id: user2.id, name: 'Exhausted', description: 'No motivation to do anything')
user2_moment1 = Moment.create(user_id: user2.id, category: Array.new(1, user2_category1.id), mood: Array.new(1, user2_mood1.id), name: 'Thanksgiving Dinner', why: 'He kept asserting to everyone that I was immature and he always did everything for me.', viewers: Array.new(1, user1.id), comment: false)
user2_moment1_comment = Comment.create(commentable_type: 'moment', commentable_id: user2_moment1.id, comment_by: user1.id, comment: "You should talk to him one-on-one and tell him how you feel!", visibility: 'all')
user1_group1_member2 = GroupMember.create(group_id: user1_group1.id, user_id: user2.id, leader: true)
