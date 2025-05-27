## 課題の回答

### まとめ
- CloudFormationテンプレートを作成し、VPC・EC2・ALB・RDS・S3を構築した。
![cfn](images/1_cfn.png)

- 以下の通り、RDSとS3への接続を確認した。（ALBのヘルスチェックはlecture13でアプリをデプロイ後、確認予定）
  - 構築したEC2にMySQLクライアントをインストールし、DBに接続できることを確認した。
![rds-access](images/2_access.png)

  - 構築したEC2からS3にアクセスし、バケットの内容を表示できることを確認した。
![s3-access](images/3_access.png)


### 1.VPC
- アベイラビリティーゾーン: ap-northeast-1a, ap-northeast-1c
- サブネット: AZごとにプライベートサブネット×1、パブリックサブネット×1
![vpc](images/4_vpc.png)


### 2.EC2
- AMI: Amazon Linux 2
- インスタンスタイプ: t2.micro
- プライベートIPアドレス: 200.0.0.27
- パブリックIPアドレス: Elastic IPアドレスを割り当て
![ec2](images/5_ec2.png)
![ec2](images/6_ec2.png)

- インバウンドルール: ポート22→ローカルPCからのみ通信を許可、ポート80→ALBからのみ通信を許可
- アウトバウンドルール: ポート80・443→全宛先への通信を許可、3306番ポート→RDS宛てのみの通信を許可
![ec2](images/7_ec2.png)


### 3.ALB
- リスナー: ポート80でターゲットグループcfn-deploy-alb-tgp宛て
- ターゲットグループ: 構築したEC2（i-063e52b5ac7a1b0d5）が対象
![alb](images/8_alb.png)
![alb](images/9_alb.png)

- インバウンドルール: ポート80で、全ての通信を許可
- アウトバウンドルール: ポート80で、EC2宛ての通信のみ許可
![alb](images/10_alb.png)


### 4.RDS
- エンジン: MySQL Community
- アベイラビリティーゾーン: ap-northeast-1a
- パブリックアクセス: なし
![rds](images/11_rds.png)

- インバウンドルール: 3306ポート、構築したEC2からのみ通信を許可
![rds](images/12_rds.png)


### 5.S3
- パブリックアクセス: ブロック
![s3](images/13_s3.png)

- IAMロール: 対象のS3でオブジェクトの取得・配置・削除と一覧表示を許可
![iamrole](images/15_role.png)

