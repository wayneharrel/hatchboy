#!/bin/bash

echo "🚀 Starting HatchBoy Demo..."
echo "============================="

# Check if setup was run
if [ ! -f "config/application.yml" ]; then
    echo "⚠️  Demo not set up yet. Running setup first..."
    ./demo_setup.sh
fi

# Start the Rails server
echo "🌐 Starting server on http://localhost:3000"
echo "📧 Demo Login: admin@hatchboy-demo.com"
echo "🔑 Password: demo123456"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

RAILS_ENV=development bundle exec rails server -p 3000 -b 0.0.0.0