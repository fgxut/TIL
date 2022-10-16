## 概要

Terraform で AWS Fargate のタスク定義に カスタムログルーティング（FireLens）用の Fluent Bit をサイドカーコンテナとして追加した場合、タスク定義を何も変更していないにもかかわらず、なぜか`terraform plan`時に`changed`が必ず発生してしまいます。

``` terraform
~ {
    - essential              = true -> null
    - mountPoints            = [] -> null
      name                   = "app"
    - volumesFrom            = [] -> null
      # (7 unchanged elements hidden)
  } # forces replacement,
~ {
    - cpu                    = 0 -> null
    - environment            = [] -> null
    - mountPoints            = [] -> null
      name                   = "log-router"
    - portMappings           = [] -> null
    - user                   = "0" -> null
    - volumesFrom            = [] -> null
      # (6 unchanged elements hidden)
  } # forces replacement,
```

## 環境

Terraform 1.2.5
Terraform AWS Provider 4.22.0

## 解決策

Fluent Bit コンテナで差分が発生しているパラメータをすべて明示的に記載すれば、`changed`が発生しなくなります。
`user = "0"`をタスク定義に追加するだけでも、同様に`changed`が発生しなくなりました。

サイドカー以外のコンテナのパラメータでも差分が発生していますが、それらのコンテナのパラメータは記載しなくても問題ありません。

以下は Fluent Bit コンテナに`user = "0"`を追加した例です。

``` json
{
  "name" : "log-router",
  "image" : "public.ecr.aws/aws-observability/aws-for-fluent-bit:latest",
  "essential" : true,
  "firelensConfiguration" : {
    "type" : "fluentbit",
    "options" : {
      "enable-ecs-log-metadata" : "true",
      "config-file-type" : "file",
      "config-file-value" : "/fluent-bit/configs/parse-json.conf"
    }
  },
  "readonlyRootFilesystem" : true,
  "memoryReservation" : 50,
  "user" : "0"
}
```

ちなみに、`user`はコンテナで使用するユーザーで、デフォルトの`UID`の`0`は`root`ユーザーです。

## 参考

- <https://github.com/hashicorp/terraform-provider-aws/issues/11526#issuecomment-872173900>
- <https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/userguide/task_definition_parameters.html#:~:text=%E3%82%BB%E3%82%AD%E3%83%A5%E3%83%AA%E3%83%86%E3%82%A3-,user,-%E3%82%BF%E3%82%A4%E3%83%97%3A%20%E6%96%87%E5%AD%97%E5%88%97>
- <https://docs.docker.jp/engine/reference/run.html>
