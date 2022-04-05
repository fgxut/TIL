# SQS

## 留意事項

### ショートポーリングとロングポ－リング

キューからメッセージを受信する方法として、ショートポーリング（0秒）とロングポーリング（1秒以上）がある。
デフォルトではショートポーリング（0秒）になっているが、この設定だとコストが高くなってしまう、かつ、以下のベストプラクティスのとおり、ほとんどの場合、最大の20秒のロングポーリングで問題ないため、20秒を設定する。

> In most cases, you can set the ReceiveMessage wait time to 20 seconds. If 20 seconds is too long for your application, set a shorter ReceiveMessage wait time (1 second minimum). If you don't use an AWS SDK to access Amazon SQS, or if you configure an AWS SDK to have a shorter wait time, you might have to modify your Amazon SQS client to either allow longer requests or use a shorter wait time for long polling.

<https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/working-with-messages.html#setting-up-long-polling>

> - Long polling lets you consume messages from your Amazon SQS queue as soon as they become available.
>   - To reduce the cost of using Amazon SQS and to decrease the number of empty receives to an empty queue (responses to the ReceiveMessage action which return no messages), enable long polling. For more information, see Amazon SQS Long Polling.
>   - To increase efficiency when polling for multiple threads with multiple receives, decrease the number of threads.
>   - Long polling is preferable over short polling in most cases.

<https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/reducing-costs.html#using-appropriate-polling-modeg>

その他参考記事

- <https://tech.uzabase.com/entry/2021/02/22/124454>
- <https://qiita.com/taka_22/items/718ec340a710bbf5e3d0>
