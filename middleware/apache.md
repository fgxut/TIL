# Apache

- <https://httpd.apache.org/docs/2.4/>
- <https://www.atmarkit.co.jp/ait/articles/0012/01/news001.html>
- <https://www.rem-system.com/centos-httpd-inst/>
- <https://qiita.com/kamihork/items/49e2a363da7d840a4149>

## Module

- <https://httpd.apache.org/docs/2.4/mod/>
- mod_rewrite
  - <https://httpd.apache.org/docs/2.4/mod/mod_rewrite.html>
  - <https://oxynotes.com/?p=7392>
- mod_deflate
  - <https://httpd.apache.org/docs/2.4/mod/mod_deflate.html>
  - <https://jyn.jp/apache-setting-deflate/>

## Directive

- <https://httpd.apache.org/docs/2.4/mod/directives.html>
- ServerName
  - <https://stackoverflow.com/questions/11279198/do-i-need-an-apache-servername-setup>
  - <https://teratail.com/questions/14807>
- KeepAliveTimeout
  - <https://httpd.apache.org/docs/2.4/mod/core.html#keepalivetimeout>
  - <https://aws.amazon.com/jp/premiumsupport/knowledge-center/apache-backend-elb/>
  - <https://dev.classmethod.jp/articles/set_keepalivetimeout_on_apache_for_resolve_elb_timeout/>

## .htaccess

- <https://httpd.apache.org/docs/2.4/howto/htaccess.html>
- <https://www-creators.com/archives/248>

## ログ

- <https://httpd.apache.org/docs/2.4/ja/logs.html>
- <https://www.atmarkit.co.jp/ait/articles/0202/16/news001_2.html>

## MPM

- <https://httpd.apache.org/docs/2.4/mpm.html>
- <https://milestone-of-se.nesuke.com/sv-basic/linux-basic/apache-mpm-prefork-worker-event/>
- <https://hacknote.jp/archives/31933/>

PHP を使用する場合、以下のため、MPM は prefork にする。
> 実行スレッドを完全に分離しなかったり、 メモリセグメントを完全に分離しなかったり、 各リクエストで使用される強力なサンドボックスを有さないことで、 基本的なフレームワークをより複雑なものにした場合、 PHP のシステムに弱点が生まれます。
<https://www.php.net/manual/ja/install.unix.apache2.php>

## チューニング

- <https://gist.github.com/koudaiii/1368b112f837d8dfbce1>
- <https://nonsensej.xyz/articles/2019/02/15/apache-tuning>
- <https://www.slideshare.net/yumemikouda/apache-69549461>
- <https://sys-guard.com/post-5216/>

## Bench

- <https://qiita.com/flexfirm/items/ac5a2f53cfa933a37192>
- <https://qiita.com/wifecooky/items/1fc87bcdf6fdcf80637e>

## セキュリティ

- <https://qiita.com/bezeklik/items/1c4145652661cf5b2271>
