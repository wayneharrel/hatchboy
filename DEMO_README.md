# 🚀 HatchBoy Demo

Welcome to the **HatchBoy** demo! This is a comprehensive team management and project tracking application built with Ruby on Rails.

## 🌟 Features

### 👥 Team Management
- Create and manage teams
- Invite team members via email
- Role-based permissions
- Team activity feeds

### ⏰ Time Tracking
- Log work hours by team and project
- Detailed time reports
- Visual charts and analytics
- Export capabilities

### ⭐ Performance Management
- Peer rating system
- Performance reviews
- MVP (Most Valuable Player) tracking
- Feedback and comments

### 📊 Reports & Analytics
- Hours worked reports
- Payment tracking
- Team performance metrics
- Interactive charts

### 💰 Payment Processing
- Stripe and PayPal integration
- Team-based payments
- Payment tracking and history
- Multiple currency support

### 🔗 Integrations
- **JIRA** - Import and sync issues
- **Trello** - Board and card synchronization
- **DocuSign** - Document signing workflow
- **Email** - Notifications and invitations

### 📄 Document Management
- Upload and share documents
- DocuSign integration
- Template management
- Version control

## 🚀 Quick Start

### Prerequisites
- Ruby 2.0.0 or higher
- PostgreSQL
- Bundler gem

### Installation

1. **Clone and Setup**
   ```bash
   git clone <repository-url>
   cd hatchboy
   chmod +x demo_setup.sh start_demo.sh
   ./demo_setup.sh
   ```

2. **Start the Demo**
   ```bash
   ./start_demo.sh
   ```

3. **Access the Application**
   - URL: http://localhost:3000
   - Email: `admin@hatchboy-demo.com`
   - Password: `demo123456`

### Alternative Setup (Manual)

1. **Install Dependencies**
   ```bash
   bundle install
   ```

2. **Configure Database**
   ```bash
   cp config/application.yml.example config/application.yml
   # Edit config/application.yml with your settings
   ```

3. **Setup Database**
   ```bash
   rake db:create db:migrate db:seed
   ```

4. **Start Server**
   ```bash
   rails server -p 3000
   ```

## 🎯 Demo Data

The demo includes:
- **5 Users**: Alice (Developer), Bob (Designer), Carol (PM), David (QA), Eva (DevOps)
- **3 Teams**: Frontend Team, Backend Team, Project Alpha
- **Sample Work Logs**: Time entries across different teams
- **Performance Ratings**: Peer reviews and feedback
- **Help Documentation**: Getting started guides

## 🔧 Configuration

### Environment Variables

Key configurations in `config/application.yml`:

```yaml
development:
  # Database
  DATABASE_USERNAME: "postgres"
  DATABASE_PASSWORD: ""
  DATABASE_HOST: "localhost"
  
  # Admin Account
  ADMIN_EMAIL: "admin@hatchboy-demo.com"
  ADMIN_PASSWORD: "demo123456"
  
  # External Services (demo keys)
  STRIPE_PUBLISHABLE_KEY: "pk_test_demo"
  JIRA_CONSUMER_KEY: "demo_jira_key"
  TRELLO_KEY: "demo_trello_key"
```

### Database Setup

For PostgreSQL setup:

**Ubuntu/Debian:**
```bash
sudo apt-get install postgresql postgresql-contrib
sudo -u postgres createuser -s $USER
```

**macOS:**
```bash
brew install postgresql
brew services start postgresql
```

**Docker:**
```bash
docker run --name postgres-demo \
  -e POSTGRES_PASSWORD=demo \
  -p 5432:5432 -d postgres
```

## 🌐 Application Structure

### Main Controllers
- `DashboardController` - Main dashboard and activity feed
- `TeamsController` - Team management
- `UsersController` - User profiles and management
- `WorkLogsController` - Time tracking
- `PaymentsController` - Payment processing
- `ReportsController` - Analytics and reporting

### Key Models
- `Account` - Main account/organization
- `User` - Team members
- `Team` - Project teams
- `WorkLog` - Time entries
- `Payment` - Payment records
- `UserMultiRating` - Performance ratings

## 🎨 UI Framework

- **Bootstrap 3** for responsive design
- **Haml** templating engine
- **jQuery** for interactions
- **Charts.js** for analytics visualization

## 🔍 Exploring the Demo

### 1. Dashboard
- Activity feed showing recent team activities
- Quick access to teams, reports, and tools
- Performance metrics overview

### 2. Teams
- Browse teams: Frontend, Backend, Project Alpha
- View team members and their roles
- Add work logs and track time

### 3. Time Tracking
- Log hours worked on different projects
- View detailed time reports
- Export data for billing

### 4. Performance Reviews
- Rate team members (1-5 stars)
- Leave constructive feedback
- View MVP rankings

### 5. Reports
- Hours worked by team/user
- Payment tracking
- Performance analytics
- Visual charts and graphs

## 🛠️ Development

### Running Tests
```bash
bundle exec rspec
```

### Code Quality
```bash
bundle exec rubocop
```

### Background Jobs
```bash
bundle exec sidekiq  # if using Sidekiq
```

## 🚨 Troubleshooting

### Common Issues

**Database Connection Error:**
- Ensure PostgreSQL is running
- Check database credentials in `config/application.yml`
- Create database user if needed

**Asset Issues:**
```bash
rake assets:clean assets:precompile
```

**Gem Conflicts:**
```bash
bundle update
```

**Permission Errors:**
```bash
chmod +x demo_setup.sh start_demo.sh
```

## 📧 Support

For questions or issues with the demo:
1. Check the troubleshooting section above
2. Review the application logs: `tail -f log/development.log`
3. Ensure all prerequisites are installed

## 🎉 Next Steps

After exploring the demo:
1. Customize team structures for your organization
2. Configure real payment processors (Stripe/PayPal)
3. Set up JIRA/Trello integrations
4. Deploy to production (Heroku, AWS, etc.)

## 📄 License

This demo application is for demonstration purposes. Please check the main application license for production use.

---

**Happy Team Managing with HatchBoy! 🚀**