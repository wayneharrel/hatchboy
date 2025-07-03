#!/bin/bash

echo "🚀 Setting up HatchBoy Demo..."
echo "================================="

# Check if we're in the right directory
if [ ! -f "Gemfile" ]; then
    echo "❌ Error: Please run this script from the HatchBoy root directory"
    exit 1
fi

# Check Ruby version
echo "📋 Checking Ruby version..."
RUBY_VERSION=$(ruby -v | cut -d' ' -f2 | cut -d'p' -f1)
REQUIRED_VERSION="2.0.0"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$RUBY_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo "⚠️  Warning: Ruby version $RUBY_VERSION detected. Recommended: $REQUIRED_VERSION or higher"
fi

# Install dependencies
echo "📦 Installing Ruby gems..."
if ! bundle install; then
    echo "❌ Failed to install gems. Please check your Ruby/Bundler setup."
    exit 1
fi

# Copy application config if it doesn't exist
if [ ! -f "config/application.yml" ]; then
    echo "⚙️  Creating application configuration..."
    cp config/application.yml config/application.yml.backup 2>/dev/null || true
    # The config is already created by our edit_file call
fi

# Check PostgreSQL
echo "🐘 Checking PostgreSQL..."
if ! command -v psql &> /dev/null; then
    echo "⚠️  PostgreSQL not found. Please install PostgreSQL:"
    echo "   Ubuntu/Debian: sudo apt-get install postgresql postgresql-contrib"
    echo "   macOS: brew install postgresql"
    echo "   Or use Docker: docker run --name postgres-demo -e POSTGRES_PASSWORD=demo -p 5432:5432 -d postgres"
    
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Setup database
echo "🗄️  Setting up database..."
echo "Creating databases..."
RAILS_ENV=development bundle exec rake db:create db:migrate 2>/dev/null || {
    echo "⚠️  Database setup failed. Please ensure PostgreSQL is running and accessible."
    echo "💡 Quick PostgreSQL setup:"
    echo "   1. Start PostgreSQL: sudo service postgresql start"
    echo "   2. Create user: sudo -u postgres createuser -s $USER"
    echo "   3. Or use Docker: docker run --name postgres-demo -e POSTGRES_PASSWORD=demo -p 5432:5432 -d postgres"
    
    read -p "Continue with seeding anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
}

# Seed demo data
echo "🌱 Seeding demo data..."
RAILS_ENV=development bundle exec rake db:seed

# Precompile assets for better performance
echo "🎨 Precompiling assets..."
RAILS_ENV=development bundle exec rake assets:precompile

echo ""
echo "✅ HatchBoy Demo Setup Complete!"
echo "================================="
echo ""
echo "🚀 To start the demo:"
echo "   ./start_demo.sh"
echo ""
echo "🌐 Or manually start with:"
echo "   bundle exec rails server -p 3000"
echo ""
echo "📱 Demo Access:"
echo "   URL: http://localhost:3000"
echo "   Email: admin@hatchboy-demo.com"
echo "   Password: demo123456"
echo ""
echo "📊 Demo Features:"
echo "   👥 Team Management"
echo "   ⏰ Time Tracking" 
echo "   ⭐ Performance Ratings"
echo "   📈 Reports & Analytics"
echo "   💰 Payment Processing"
echo "   📄 Document Management"
echo ""
echo "💡 Tip: The demo includes sample teams, users, and data to showcase all features!"