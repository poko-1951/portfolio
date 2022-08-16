![header_logo_2](https://user-images.githubusercontent.com/103019339/184818644-9f710bfa-2035-42d1-8795-6029ab3c8374.png)

# Converce

Conversation piece（話の種、話題）の略語

## サイト概要

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
  - 仲良くなりきれていない友人との会話
  - 大切な人とのデート

## 使い方

## 使用技術

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

## 設計書

### ER 図
![PF ER図](https://user-images.githubusercontent.com/103019339/184848376-1b099d0e-2ed9-4f52-9233-71a64aa9e3e6.jpg)


### インフラ構成図

### 関連リンク

- [Qiita](https://qiita.com/ten__)
- [twitter](https://twitter.com/poko11542890)
- [Notion](https://witty-uncle-5aa.notion.site/Daily-Report-ae3c06e9df29419e97b5002918e2bb4f)

## 使用素材

- [Loose Drawing](https://loosedrawing.com/)
