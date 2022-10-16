# How to create local temporary files in Terraform

## 概要

Terraform で`terraform apply`時にローカルファイルを一時的に作成し、そのファイルを使用後に削除する方法について記載します。
Terraform で一時ファイルを作成する機能は、バージョン`1.2.5`ではないようです。

## 環境

Terraform 1.2.5

## 方法

方法は 2 つありますが、2 つめの方法を私はお勧めします。

### 1. `local_file`でファイルを作成し、`null_resource`で使用後削除する

まず思いつくのは、この方法だと思います。
しかしこの方法だと、`terraform apply`時に毎回ローカルファイルの作成が実行されることになり、状態の差分が発生しています。

```hcl
# 1.ファイルを作成する
resource "local_file" script {
  content  = var.script_content
  filename = "${path.root}/.terraform/tmp/${timestamp()}.txt"
}

# 2. 作成したファイルをなんらかで使用する
resource "null_resource" scriptExec {
  triggers = {
    once = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = "/usr/bin/third/party/binary-f ${local_file.script.filename}"
  }
}

# 3. 使用後にファイルを削除する
resource "null_resource" deleteLocalFile {
  triggers = {
    once = timestamp()
  }

  depends_on = [
    null_resource.scriptExec,
  ]

  provisioner "local-exec" {
    command = "rm -rf ${local_file.script.filename}"
  }
}
```
※ 以下のコメントのコードを引用し、コメントを付与しています。
<https://github.com/hashicorp/terraform/issues/21308#issuecomment-721478826>

### 2. `null_resource`でファイルを作成し、`null_resource`で使用後削除する

`null_resource`でファイルの作成・使用・削除をすべて行う方法です。
この方法ならば、一時的に使用したいファイルの作成元となるファイルの内容を一時ファイル作成のトリガーにしているため、作成元ファイルの内容を変更したときにのみ、一時ファイルが作成・使用・削除されます。

```hcl
# 1. 一時ファイルの作成元ファイルをレンダリングする
data "template_file" "original_file" {
  template = file("${path.module}/file.ori.conf")

  vars = {
    HOGE = var.common["hoge"]
  }
}

# 2. ファイルを作成する
resource "null_resource" "create_file" {
  triggers = {
    file_content = md5(file("${path.module}/file.ori.conf"))
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.original_file.rendered}' > ${path.module}/file.conf"
  }
}

# 3. ファイルを使用・削除する
resource "null_resource" "use_and_delete_file" {
  triggers = {
    file_content = md5(file("${path.module}/file.ori.conf"))
  }

  depends_on = [
    null_resource.null_resource
  ]

  provisioner "local-exec" {
    command = "sh ${path.module}/hoge.sh ; rm -rf ${path.module}/file.conf"

    environment = {
      HOGE = var.common["hoge"]
    }
  }
}
```

## 参考

- <https://github.com/hashicorp/terraform/issues/21308#issuecomment-721478826>
