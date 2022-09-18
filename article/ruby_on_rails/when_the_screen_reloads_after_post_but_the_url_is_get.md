#概要

【Rails】POST後の画面をリロードしたのにURLをGETしてしまうときの対処法

Ruby on Railsにおいてフォームでバリデーションエラーになったあと、その画面をリロードしたときに、URLへのリクエストメソッドがPOSTではなくGETになってしまうという問題が起きました。
どのようにしてその問題を解決すれば良いか、調べてもすぐにはわからなかったので、本記事ではその対処法などについてまとめます。

#環境
Ruby 2.6.4
Ruby on Rails 5.2.3
Turbolinks 5.2.1

#問題
###期待していた動き
フォームでバリデーションエラーになったあと、その画面をリロードしたときに、
画面上に「フォーム再送信の確認」というダイアログが出る。
<img width="446" alt="スクリーンショット 2019-11-17 22.48.00.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/411056/8b2ee0c3-0354-8a4b-8b2b-a7b6083f9f45.png">

###実際の動き
URLへのリクエストメソッドがPOSTではなくGETになってしまい、
GETメソッドでの/usersへのルーティングがないため、その旨のエラー画面が表示されてしまった。
<img width="331" alt="スクリーンショット 2019-11-17 21.21.26.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/411056/ebcb6c8d-e7c0-aa26-1aa5-6229c9aa3dea.png">

#原因
Turbolinksが原因です。
Turbolinksがhistory apiで履歴を操作しており、history apiに履歴を足すときはGETメソッドでのURLしか足せないため、URLをGETで取得しようとする…らしいです。
正直くわしいところはわかりませんでした。

Turbolinksとは、jsとcssの読み込み処理を省略することで、画面遷移を高速化させる組み込みライブラリです。
くわしくは、以下の記事をご参照ください。

- [Turbolinks5についてまとめてみる](https://qiita.com/saboyutaka/items/bb089e8208239bf6fdc0)
- [『Turbolinks』って、なんぞ？](https://www.ryotaku.com/entry/2019/01/15/213420)

#対処法
###1. `application.js` から`//= require turbolinks`を削除する。
####Before

```app/assets/javascripts/application.js
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
```

####After

```app/assets/javascripts/application.js
//= require rails-ujs
//= require activestorage
//= require_tree .
```

これで問題は解決されますが、Turbolinksは不要になったので、これ以降の手順もしましょう。

###2. `Gemfile`から`gem 'turbolinks'`を削除する。
####Before

```Ruby:Gemfile
# (前略)
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# (後略)
```
####After

```Ruby:Gemfile
# (前略)
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
# (後略)
```

###3. `application.html.erb `から`data-turbolinks-track': 'reload'`を削除する。
####Before

```Ruby:app/views/layouts/application.html.slim
doctype html
html
  head
    title
      | Application
    = csrf_meta_tags
    = csp_meta_tag
    = stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload'
    = javascript_include_tag 'application', 'data-turbolinks-track': 'reload'
# (後略)
```

####After

```Ruby:app/views/layouts/application.html.slim
doctype html
html
  head
    title
      | Application
    = csrf_meta_tags
    = csp_meta_tag
    = stylesheet_link_tag    'application', media: 'all'
    = javascript_include_tag 'application'
# (後略)
```

#参考

- [Turbolinks doesn't recognize form re-submission [POST] and navigates instead [GET]. ](https://github.com/turbolinks/turbolinks/issues/251)
- [Turbolinks5でPOSTするときはajax経由のほうが良いのかも](https://memo.willnet.in/entry/2018/09/02/165809)
