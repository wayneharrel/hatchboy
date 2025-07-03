# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

# HatchBoy Demo Data Seeds
puts "🌱 Seeding HatchBoy demo data..."

# Create Admin Account
puts "Creating admin account..."
admin = Account.find_or_create_by(email: ENV['ADMIN_EMAIL'] || 'admin@hatchboy-demo.com') do |account|
  account.name = ENV['ADMIN_NAME'] || 'Demo Admin'
  account.password = ENV['ADMIN_PASSWORD'] || 'demo123456'
  account.password_confirmation = ENV['ADMIN_PASSWORD'] || 'demo123456'
  account.confirmed_at = Time.current
end

# Create Demo Company
puts "Creating demo company..."
company = Company.find_or_create_by(name: "HatchBoy Demo Corp") do |c|
  c.description = "A demo company showcasing HatchBoy's team management capabilities"
  c.website = "https://demo.hatchboy.com"
end

# Create Demo Users
puts "Creating demo users..."
demo_users = [
  { name: "Alice Johnson", email: "alice@demo.com", role: "Developer" },
  { name: "Bob Smith", email: "bob@demo.com", role: "Designer" },
  { name: "Carol Davis", email: "carol@demo.com", role: "Project Manager" },
  { name: "David Wilson", email: "david@demo.com", role: "QA Engineer" },
  { name: "Eva Brown", email: "eva@demo.com", role: "DevOps" }
]

users = demo_users.map do |user_data|
  User.find_or_create_by(email: user_data[:email]) do |user|
    user.name = user_data[:name]
    user.account_id = admin.id
    user.company_id = company.id
    user.bio = "Demo #{user_data[:role]} for HatchBoy showcase"
  end
end

# Create Demo Teams
puts "Creating demo teams..."
teams_data = [
  {
    name: "Frontend Team",
    description: "Responsible for user interface and user experience",
    members: [users[0], users[1]] # Alice, Bob
  },
  {
    name: "Backend Team", 
    description: "API development and server-side logic",
    members: [users[0], users[4]] # Alice, Eva
  },
  {
    name: "Project Alpha",
    description: "Cross-functional team working on Project Alpha",
    members: [users[2], users[0], users[3]] # Carol, Alice, David
  }
]

teams = teams_data.map do |team_data|
  team = Team.find_or_create_by(name: team_data[:name]) do |t|
    t.description = team_data[:description]
    t.account_id = admin.id
  end
  
  # Add team members
  team_data[:members].each do |user|
    TeamsUser.find_or_create_by(team: team, user: user) do |tu|
      tu.role = 'member'
    end
  end
  
  team
end

# Create Sample Work Logs
puts "Creating sample work logs..."
work_logs_data = [
  { user: users[0], team: teams[0], hours: 8, description: "Implemented new dashboard components", date: 2.days.ago },
  { user: users[1], team: teams[0], hours: 6, description: "Designed user onboarding flow", date: 1.day.ago },
  { user: users[0], team: teams[1], hours: 4, description: "API endpoint optimization", date: 3.days.ago },
  { user: users[4], team: teams[1], hours: 5, description: "Server deployment and monitoring setup", date: 2.days.ago },
  { user: users[2], team: teams[2], hours: 7, description: "Project planning and stakeholder meetings", date: 1.day.ago },
  { user: users[3], team: teams[2], hours: 6, description: "Test automation and bug fixes", date: 2.days.ago }
]

work_logs_data.each do |log_data|
  WorkLog.find_or_create_by(
    user: log_data[:user],
    team: log_data[:team], 
    created_at: log_data[:date]
  ) do |wl|
    wl.hours = log_data[:hours]
    wl.description = log_data[:description]
    wl.log_date = log_data[:date].to_date
  end
end

# Create Sample Ratings
puts "Creating sample ratings..."
rating_data = [
  { from: users[2], to: users[0], rating: 5, comment: "Excellent technical skills and great collaboration" },
  { from: users[0], to: users[1], rating: 4, comment: "Creative designs and attention to detail" },
  { from: users[1], to: users[0], rating: 5, comment: "Always helpful and produces quality code" },
  { from: users[2], to: users[3], rating: 4, comment: "Thorough testing and finds critical issues" }
]

rating_data.each do |rating|
  UserMultiRating.find_or_create_by(
    from_user: rating[:from],
    to_user: rating[:to]
  ) do |umr|
    umr.rating = rating[:rating]
    umr.comment = rating[:comment]
  end
end

# Create Sample Posts
puts "Creating sample posts..."
posts_data = [
  { user: users[2], title: "Team Meeting Notes", content: "Weekly sync meeting outcomes and action items for Project Alpha team.", team: teams[2] },
  { user: users[0], title: "Code Review Guidelines", content: "New guidelines for code review process to improve code quality.", team: teams[0] },
  { user: users[4], title: "Deployment Update", content: "Successfully deployed v2.1 with improved performance and bug fixes.", team: teams[1] }
]

posts_data.each do |post_data|
  Post.find_or_create_by(title: post_data[:title]) do |post|
    post.content = post_data[:content]
    post.user = post_data[:user]
  end
end

# Create Help Links
puts "Creating help links..."
help_links_data = [
  { title: "Getting Started with HatchBoy", url: "#", description: "Complete guide to setting up your first team" },
  { title: "Time Tracking Best Practices", url: "#", description: "How to effectively track and report work hours" },
  { title: "Team Ratings Guide", url: "#", description: "Guidelines for giving constructive feedback" },
  { title: "Integration Setup", url: "#", description: "Connect JIRA, Trello, and other tools" }
]

help_links_data.each do |help_data|
  HelpLink.find_or_create_by(title: help_data[:title]) do |hl|
    hl.url = help_data[:url]
    hl.description = help_data[:description]
  end
end

puts "✅ Demo data seeded successfully!"
puts "\n📊 Demo Summary:"
puts "  👤 Users: #{User.count}"
puts "  👥 Teams: #{Team.count}" 
puts "  ⏰ Work Logs: #{WorkLog.count}"
puts "  ⭐ Ratings: #{UserMultiRating.count}"
puts "  📝 Posts: #{Post.count}"
puts "  🆘 Help Links: #{HelpLink.count}"
puts "\n🚀 Demo ready! Login with:"
puts "  📧 Email: #{admin.email}"
puts "  🔑 Password: #{ENV['ADMIN_PASSWORD'] || 'demo123456'}"
