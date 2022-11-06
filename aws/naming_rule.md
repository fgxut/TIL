# AWS リソースの個人的な命名規則

## 基本ルール

- 単語間はハイフン（-）で結ぶ
- 英小文字と数字のみを使用し、マルチバイト文字、英大文字、記号、アンダースコア（_）は使用しないようにする
- {環境名}-{任意の名前}を基本に、各AWSリソースで必要であればサフィックスを付与する
サフィックスを付与するAWSリソースは、基本的にほかのAWSリソースと入れ子のように関係するものとする
たとえば、ネットワークに関するものやELB - TargetGroup、IAMRole - IAMPolicy、ECSCluster - ECSServiceなど

## 命名規則表

- 環境（env）
  - 本番、ステージング、検証（prd, stg, dev）
- ネットワークレイヤー（nlayer）
  - パブリック、プロテクト、プライベート（public, protected, private）[^1]
- アベイラビリティゾーン（az）
  - 東京a、東京c、バージニア北部cなど（ap-northeast-1a, ap-northeast-1c, us-east-1c, etc.）
- 任意の名前（XXXX）
  - 種別や目的など（app, api, bastion, mail, logs, contents, images, etc.）

[^1]: サブネットは上記の表のとおりルーティングで区別する。

| AWSリソース     | 命名規則                                                                                             | 備考                                                                                                                                                                                      |
| --------------- | ---------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| VPC             | {env}-{XXXX}-vpc                                                                                     |                                                                                                                                                                                           |
| Subnet          | {env}-{XXXX}-{nlayer}-subnet-{az}                                                                    |                                                                                                                                                                                           |
| RouteTable      | {env}-{XXXX}-{nlayer}-rtb                                                                            | NAT GawatayをAZ毎に分ける場合はprotectedのみ連番を付与                                                                                                                                    |
| InternetGateway | {env}-{XXXX}-igw                                                                                     |                                                                                                                                                                                           |
| SecurityGroup   | {env}-{XXXX}-sg                                                                                      |                                                                                                                                                                                           |
| ELB             | {env}-{XXXX}-{alb, nlb, clb}                                                                         | インターナルなELBを作成する場合、役割毎に分ける場合はその部分も考慮                                                                                                                       |
| TargetGroup     | {env}-{XXXX}-tg                                                                                      | 同上                                                                                                                                                                                      |
| IAMRole         | {env}-{XXXX}-role                                                                                    |                                                                                                                                                                                           |
| IAMPolicy       | {env}-{XXXX}-policy                                                                                  |                                                                                                                                                                                           |
| ECSCluster      | {env}-{XXXX}-cluster                                                                                 |                                                                                                                                                                                           |
| ECSService      | {env}-{XXXX}-service                                                                                 |                                                                                                                                                                                           |
| AuroraCluster   | {env}-{XXXX}-cluster                                                                                 |                                                                                                                                                                                           |
| AuroraInstance  | {env}-{XXXX}-instance-{XX}                                                                           | 末尾には連番を付与                                                                                                                                                                        |
| RDS             | {env}-{XXXX}-rds                                                                                     |                                                                                                            |
| S3              | {env}-{XXXX}-{AccountID}                                                                             | AccountIDを付与するのは全世界で一意になるようにするため。AccountIDは数字のみでハイフンは付与しない。ホスティング用はapp-、ログ用はlogs-、静的ファイル用はimages-をAccountIDの前に付与する |
| CloudWatchAlarm | {AWS Service}\_{ResourceName}\_{CloudWatch Metrics}\_is\_{over\|under}\_{warning\|critical}\_threshold | この命名規則は基本ルールに反し、メトリクス名などが大文字で含まれいたり、単語間の区切りがアンダーバーになっていたりしているが、そのほうがわかりやすくアラームへの対処が早くなるため、例外とする                      |
| その他          | {env}-{XXXX}                                                                                         | 複数ある場合は連番を付与                                                                                                                                                                  |

### ネットワークレイヤー（nlayer）についての表

| サブネット              | ルーティング     | VPC外への通信 | VPC外からの通信          |
| ----------------------- | ---------------- | ------------- | ------------------------ |
| パブリック（public）    | Internet Gateway | 可            | 可（パブリックIPが必要） |
| プロテクト（protected） | NAT Gateway      | 可            | 踏み台サーバー経由       |
| プライベート（private） | -                | 不可          | 踏み台サーバー経由       |

## 参考

- https://dev.classmethod.jp/articles/aws-name-rule/
