#!/bin/bash

#------------------------ INSTRUCTIONS ------------------------
#   1. Navigate to the folder you want to make a Git repository
#      "cd /path/to/your/folder"
#
#   2. Run the script 
#      Ex: "/path/to/link_gitrepo.sh" 
#--------------------------------------------------------------

# Function to check SSH key authentication
check_ssh() {
    echo "Checking SSH key authentication with GitHub..."
    ssh -T git@github.com &>/dev/null
    if [ $? -ne 1 ]; then
        echo "Error: Unable to authenticate with GitHub via SSH."
        echo "Ensure your SSH key is added to your GitHub account or generate a new one."
        echo "For help: https://docs.github.com/en/authentication/connecting-to-github-with-ssh"
        exit 1
    fi
    echo "SSH authentication with GitHub is working."
}

# Prompt for repository name
echo "Enter the name of your repository <repository-name>:"
read -r REPO_NAME

# Check if a repository name was provided
if [ -z "$REPO_NAME" ]; then
    echo "Error: Repository name can't be empty and/or an invalid name was entered.."
    exit 1
fi

# Define your GutHub username
#GITHUB_USERNAME="<your-github-username>" 
GITHUB_USERNAME="Hazofinho"

# Initialize the local repository
git init
echo "Initialized empty Git repository."

# Create .gitignore and README.md if they don't exist
touch .gitignore
echo ".vscode/" >> .gitignore
echo "Created .gitignore."

touch README.md
echo "# $REPO_NAME" > README.md
echo "Created README.md with repository name as the title."

# Add and commit files
git add .
git commit -m "Initial commit"
echo "Staged and committed initial files."

# Link to remote repository using SSH
REMOTE_URL="git@github.com:$GITHUB_USERNAME/$REPO_NAME.git"
git remote add origin $REMOTE_URL
echo "Added remote origin: $REMOTE_URL"

# Rename branch to main
git branch -M main

# Push to GitHub
git push -u origin main
echo "Pushed to GitHub successfully."