![header_logo_2](https://user-images.githubusercontent.com/103019339/184818644-9f710bfa-2035-42d1-8795-6029ab3c8374.png)
![logo 001](https://user-images.githubusercontent.com/103019339/185021321-59dc15e9-a034-4e30-8614-3099b1a7234a.jpeg)

# Converce

Conversation piece（話の種、話題）の略語

## 【サイト概要】

### サイトテーマ

誰しも、うまく会話が弾まず気まずい空気になったことがあるはずだ。何を話そうかと考えれば考えるほど、話題がでてこない。そもそも、その人の好きなことってなんだっけ。こんなときに、何かいい話題が出てくれば…そんな世の中の悩みを解決するための話題提供サービス。

### テーマ選定理由

自分自身が口下手であり、人と話すときに話題が思い付かず、気まずい体験をすることが少なくない。改めて考えると、このような機会は誰にでも当てはまるし、多くの人が困っているのではないかと思ったため。

### ターゲットユーザ

- 会話が見つからずに困っている方
- 相手の性格や好きなことを書き記しておきたい方
- カレンダーに誰かと会うスケジュールを登録しておきたい方
- 年齢層は問わない

### 利用シーン

- ビジネス
  - ミーティングの空き時間
  - クライアントとの食事会
- プライベート
  - 友人との会話
  - 大切な人とのデート

## 【機能説明、使い方】
| トピック投稿機能 | トピック閲覧機能 |
|--|--|
| ![logo 002](https://user-images.githubusercontent.com/103019339/185021334-104dfcb0-dacc-46ab-9181-29b42eea2dd6.jpeg) | ![logo7 001](https://user-images.githubusercontent.com/103019339/185152507-d8f1ed68-ea84-4b55-a642-2f90dfbddad3.jpeg)|
|トピック投稿ボタンから話題になりそうな事柄を投稿することができます。<br>また、1つのトピックに対して、タグは複数個設定することができます。|他の人が投稿したトピックを閲覧することができます。<br>気に入ったトピックを保存したり、コメントを付けることが可能です。|

| お知り合い管理機能                                                                                                 | スケジュール管理機能 |
| -------------------------------------------------------------------------------------------------------------------- | ----- |
|![logo 003](https://user-images.githubusercontent.com/103019339/185021338-6f77e89a-5628-42e8-9d65-1dcc8ec9b8b5.jpeg)| ![logo 004](https://user-images.githubusercontent.com/103019339/185021340-fb321693-7e6f-4662-95a4-962b8e7824ec.jpeg) |
| あなたが普段お話しするお知り合いの情報を登録できます。<br>さらに、お知り合いごとに、その人に適したトピックを見つけたら、ストックしておくことができます。| あなたのスケジュールをカレンダーで管理しましょう。<br>登録したスケジュールはドラッグ&ドロップで移動できるため、直感的な操作が可能です。<br>さらに、予定が近づくとリマインダーメールにてお知らせします。      |

## 【使用技術】

### フロントエンド

- HTML/CSS/JavaScript
- CSS frame-work
  - Bootstrap

### バックエンド

- Ruby 3.1.2
- Rails 6.1.6
  <details>
  <summary>gem</summary>

  - devise, devise-i18n: ユーザー認証
  - kaminari: 無限スクロール(jscroll 併用)
  - ransack: 検索機能
  - rinku: リンク有効化
  - net-smtp, net-pop, net-imap: メール関連
  - meta-tags: SEO 対策
  - whenever: バッチ処理
  - rspec-rails: テスト
  - rubocop, rubocop-performance, rubocop-rails, rubocop-minitest, rubocop-packaging, rubocop-rspec: リファクタリング
  - pry-rails, annotate: デバッグ
  - mysql: データベース
  </details>

### テスト

- RSpec

### インフラ

- AWS
  - VPC
  - EC2(Amazon Linux 2)
  - RDS
  - EIP
  - Route 53
  - Cluod Watch
- Nginx
- Puma
- MySQL

## 【設計書】

### ER 図

![PF ER図](https://user-images.githubusercontent.com/103019339/184848376-1b099d0e-2ed9-4f52-9233-71a64aa9e3e6.jpg)

### インフラ構成図

![【Readme】インフラ構成図](https://user-images.githubusercontent.com/103019339/184938913-ac5f0350-7d23-4285-b6e8-92b902a3eb36.jpg)

### 関連リンク

- [Qiita](https://qiita.com/ten__)
- [twitter](https://twitter.com/poko11542890)
- [Notion](https://witty-uncle-5aa.notion.site/Daily-Report-ae3c06e9df29419e97b5002918e2bb4f)

## 【使用素材】

- [Loose Drawing](https://loosedrawing.com/)
