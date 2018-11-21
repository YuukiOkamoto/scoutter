# Scoutter
Twitterの1日の活動量で戦闘力を測るアプリ  
日々戦闘力を蓄積し強く育てていく

## Why do we do it?
Twitter運用を多くの人が楽しく続けられることを目指す。  
私たちが考えるTwitterの問題として、良いツイッタラーとされる指標は
- フォロワー数
- 被ふぁぼ
- 被RT
- 被リプ

などの受動的なものであることです。  
このことにより、フォロワー数が多くないと良い発信をしても反応が少なく、  
Twitterを続けることが嫌になってしまうことがあります。  
（Twitter好きの自分としては見過ごせない事案です！！）

ということで、  
Twitterでどれだけ
- Activeに交流しているか
- Activeに発信しているか

を指標に戦闘力を計測し、  毎日楽しく育てていくアプリを作成しました。  
戦闘力の上昇を目指して日々Activeな活動をすることで、いずれはTwitterで良いツイッタラーとされるフォロワー数なども上昇すると確信しています。

## Feature
サービスの作成期間は1ヶ月でした。  
1ヶ月で上記の問題解決を達成できる*使ってもらえる*アプリケーションを作成する必要がありました。  
よって、実装しない機能と画面を明確化しシンプルなアプリケーションとすることにしました。  
第一にTwitterからの流入し、Twitterに出ていくサイクルを廻せるようしました。  
戦闘力を測定すると、Twitterにシェアすることもランキングを見ることも出来ます。またランキングからはTwitterのユーザーページに飛ぶことも出来ます。そして交流などのアクション後また戦闘力を測りに戻ってきます。  
これにより、ユーザー情報や他ユーザーへのアクション・交流はTwitterに委譲し、私たちのアプリケーションでは実装しないことを成功しました。

## Ruby version
* See `.ruby-version`.

## Rails version
* See `Gemfile`.

## System dependencies
* MySQL >= 5.6

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
*AWSのアクセスキー,TwitterのAPIキーなどは個別に担当者に聞いてください。*
## Database creation
```
$ rake db:create db:reset
```

## Database initialization
```
$ rake db:seed_fu
```

## Deploy
*Master Branch*
```
bundle exec cap production deploy
```
*〇〇 Branch*
```
BRANCH=〇〇 bundle exec cap production deploy
```
※productionにデプロイする場合、`'~/.ssh/id_rsa'`に秘密鍵を作成し担当者にサーバーにて公開鍵の登録を依頼してください

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

### Force login

- See `app/controllers/development/sessions_controller.rb`

```
/login_as/[user_id]
```
