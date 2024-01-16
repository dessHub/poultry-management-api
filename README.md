# poultry-management-api

API collections [documentation](https://documenter.getpostman.com/view/3652853/2s9YsQ8qDs)

## Step by Step - Install & Configuration

## System dependencies

- PostgreSQL
- Ruby version 3.1.4
- Rails version 7.0.4

# Manual Setup (This will depend on your OS)

**1. Install Homebrew**

Homebrew allows us to install and compile software packages easily from source.

Run the following command in the Terminal. When it asks you to install Xcode CommandLine Tools, say yes

`ruby -e “$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)”`

**2. Instal Ruby**

```
brew install rbenv ruby-build
```

Add rbenv to bash so that it loads every time you open a Terminal

```
echo ‘if which rbenv > /dev/null; then eval “$(rbenv init -)”; fi’ >> ~/.bash_profile
source ~/.bash_profile
```

Install Ruby 3.1.4 which is required by the app:

```
rbenv install 3.1.4
rbenv global 3.1.4
ruby -v
```

**3. Install Rails**

Installing Rails is really simple:

```
gem install rails -v 7.0.4
rbenv rehash
rails -v
```

**4. Install PostgreSQL**

```
brew install postgresql
```

Make sure to follow those instructions of the build notes.

If your installing PostgreSQL for the first time create a database:

```
initdb /usr/local/var/postgres -E utf8
```

Lunchy is a helpful gem that will allow you to easily start and stop Postgres.

```
gem install lunchy
```

Change the version number of PostgreSQL to the version that you installed:

```
mkdir -p ~/Library/LaunchAgents
cp /usr/local/Cellar/postgresql/0.0.0/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
```

To Stop PostgreSQL run:

```
lunchy stop postgres
```

We want it to start PostgreSQL, so instead run:

```
lunchy start postgres
```

**5. Clone the app**

Browse to where you want the app to live and clone app (using SSH):

```
git clone git@github.com:dessHub/poultry-management-api.git
```

Change directory into the stories folder

```
cd poultry-management-api
```

**8. Create .env and update the environment variables. **

Check `.env-sample` for expected variables and update accordingly.

**6. Start the app**

First install all the required gems:

```
bundle install
```

Set database credentials in `.env` accordingly.
Set up and migrate the database.
Seed the database:

```
bin/rails db:setup
bin/rails db:migrate
bin/rails db:seed
```

Lets run the App:

```
rails server -p PORT
```

Then browse to [http://localhost:3001](http://localhost:3001) to view the app in all its glory.

**7. How to contribute**

### 1. Branch off `develop` branch

### 2. Create a descriptive branch depending on the issue

      - Feature: `ft-[descriptive-name]` e.g `ft-login`
      - Bug: `bg-[descriptive-name]` e.g `bg-username-validation`
      - Chore: `ch-[descriptive]`. Chore is for the tasks that aren't features or bugs, like setting up deployment configurations.

### 3. Open a PR to `develop` branch.

### 4. Wait for approval before merging the PR.

### 5. Always make sure you are branching off upto date `develop` branch by pulling remote `develop`.

```
git pull origin develop

```
