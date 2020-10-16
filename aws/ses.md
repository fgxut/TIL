# SES

E メール送信のサービス
- <https://docs.aws.amazon.com/ja_jp/ses/latest/DeveloperGuide/send-email-concepts-deliverability.html>
- <https://docs.aws.amazon.com/ja_jp/ses/latest/DeveloperGuide/send-email-getting-started-migrate.html>
- <https://docs.aws.amazon.com/ja_jp/ses/latest/DeveloperGuide/success-metrics.html>
- <https://docs.aws.amazon.com/ja_jp/ses/latest/DeveloperGuide/best-practices.html>
- <https://www.slideshare.net/AmazonWebServicesJapan/aws-30934799>

## メールの仕組み

- <https://ascii.jp/serialarticles/433055/>

### バウンス

メールを配信できなかったこと。バウンスが発生すると、（その原因は受信側のメールサーバにある）、メーラーは配信失敗を示す通知を受け取る。

- ソフトバウンス（もしくはブロック）: メールアドレスが正しく、受信者のサーバに到達したが、以下のような理由で返されたこと
  - メールボックスが一杯だった
  - サーバがダウンしていた
  - メッセージサイズが大きすぎた
- ハードバウンス: 以下のような理由で受信を恒久的に拒否されたこと
  - メールアドレスが無効/不正
  - メールアドレスが存在しない

バウンスを減らす対策

> - 宛先リストをクリーンに保つ。不正なメールアドレスや、反応の一切ない受信者は定期的に宛先リストから削除しましょう。バウンス率はレピュテーションに影響があるため、リストをクリーンに保つことで高い到達率が期待できます。SendGridでは、バウンスリストの管理をダッシュボードで容易に行うことができ、一定期間が経過したアドレスを自動削除したり、エラーメッセージを転送するなどの設定も可能です。
> - ダブルオプトインを採用する。宛先リストへの追加時に、確認のメールを送信します。それにより、メールアドレスが有効であることに加え、メールを受取る意思があるかの確認にもなります。
> - 配信状況をモニタリングする。返信率だけでなく、バウンス率にも注意を払います。常時モニタリングを行うことにより、潜在的な問題を未然に防いだり、大きな問題に発展する前に気づくことが可能になります。
> 
<https://docs.aws.amazon.com/ja_jp/ses/latest/DeveloperGuide/Welcome.html>

### DKIM(DomainKeys Identified Mail)

電子署名を用いた送信ドメイン認証

> 受信側のメールサーバで、メールのヘッダーに付与された電子署名を、送信ドメインのDNSが公開する公開鍵(一般に公開されている暗号化に必要なもの)を使い照合することで、メールの送信者とメール本文の正当性を評価します。正当な送信元ドメインとして認証するため、なりすましメール対策が実現できます。

<https://ms.repica.jp/column/07/>

- <https://sendgrid.kke.co.jp/blog/?p=2044>

### SPF(Sender Policy Framework)

DNS を用いた送信ドメイン認証

> SPFは、メール送信元IPアドレスを送信側のDNSサーバへあらかじめ登録することで確認を行います。DNSサーバはドメイン名とIPアドレスを紐づけるデータベースを管理しているため、ドメイン名の問い合わせに対してIPアドレスを答える役割を担っています。また、DNSサーバへ登録する情報は「SPFレコード」と呼びます。
> 受信者はメールを受信した際に、送信元のDNSサーバへSPFレコードを要求し、その回答と実際の送信元IPアドレスが一致するか確認することで、送信ドメインの認証を実施します。

<https://ms.repica.jp/column/06/>

- <https://sendgrid.kke.co.jp/blog/?p=3509>
- <https://salt.iajapan.org/wpmu/anti_spam/admin/operation/information/spf_i01/>
- <https://tech.akat.info/?p=1657>
