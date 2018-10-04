# Scoutter
Twitterの活動量で戦闘力を測るアプリ

## Ruby version
* See `.ruby-version`.

## Rails version
* See `Gemfile`.

## System dependencies
* MySQL >= 5.5

## Project initiation
* リポジトリのクローン
```
$ git clone git@github.com:YuukiOkamoto/scoutter.git
```
* gemのインストール
```
$ bundle install --path vendor/bundle
```

## Configuration
*ファイルの中身はご自身の環境に合わせて適宜変更してください*
* データベースの設定
```
$ cp config/database.yml.default config/database.yml
```
* 環境変数の設定
```
$ cp .env.default .env
```
*AWSのアクセスキーなどは個別に担当者に聞いてください。*
## Database creation
```
$ rake db:create db:reset
```

## Database initialization
```
$ rake db:seed
```

## How to run the static code analysis
#### Rubocop
```
$ bundle exec rubocop -R
```

#### Rails best practices
```
$ bundle exec rails_best_practices
```

#### SCSS-Lint
```
$ bundle exec scss-lint
```

#### Slim-Lint
```
$ bundle exec slim-lint
```
