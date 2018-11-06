# README

## PunchApp
アプリケーションURL：　　
かんたん操作で勤怠表に時間を記録することができます。  
使い方の詳細はアプリケーション内の「About」ページに書いてあります。  

## 開発環境
Ruby 2.4.1  
Rails 5.4.1  
AWS Cloud9よりherokuを使用しデプロイしました　　

## 工夫したこと
- ユーザのログイン・ログアウト機能はrails tutorialを踏襲しそれを骨組みに打刻機能などを実装しました。
- Homeのユーザー一覧やプロフィールページのタブ切り替えにはリンクを押した際にパラメーターを渡しセッションに値を保存、ページ内でセッションの値による条件分岐をさせることで表示タブを切り替えています。  
- 過去の打刻時間を日付リストを選択することで検索できるようにするためDisplaydateモデルを用意しDBにデフォルトで表示させるページの日付情報を保存、ユーザーがページで日付リストを変更する度にDBの情報を更新し、選択された日付と同じ日付を持つデータを呼び出すという方法で検索機能を実装しました。
- なるべく直感的に操作できるようなシンプルで見やすいレイアウトを意識して配色等のデザインをしてみました。
