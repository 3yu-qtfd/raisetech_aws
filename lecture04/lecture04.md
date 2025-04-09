## 課題の回答

### 1.今回作成したVPC
- アベイラビリティーゾーン: ap-northeast-1a, ap-northeast-1c
- サブネット: AZごとにプライベートサブネット×1、パブリックサブネット×1
![vpc](images/1_vpc.png)

### 2.今回作成したEC2
- AMI: Amazon Linux 2
- インスタンスタイプ: t2.micro
- プライベートIPアドレス: 100.0.0.5
- パブリックIPアドレス: 自動割り当て
![ec2-overall](images/2_ec2.png)
![ec2-detail](images/3_ec2.png)

- セキュリティ
  - インバウンドルール: SSH通信を許可（ローカルPCからのみ）
  - アウトバウンドルール: HTTP通信とHTTPS通信を許可（全宛先）、RDSへの通信を許可（構築したRDS宛てのみ）
![ec2-security](images/4_ec2.png)

- ネットワーク
  - アベイラビリティーゾーン: ap-northeast-1a
  - サブネット: パブリックサブネット
![ec2-netowork](images/5_ec2.png)

- ストレージ
  - ボリュームサイズ: 16GiB
![ec2-storage](images/6_ec2.png)

### 3.今回作成したRDS
- エンジン: MySQL Community

- ネットワークとセキュリティ
  - アベイラビリティーゾーン: ap-northeast-1a
  - パブリックアクセス: なし
![rds-overall](images/7_rds.png)

- セキュリティ②
  - インバウンドルール: EC2からの通信を許可（構築したEC2からのみ）
![rds-overall](images/8_rds.png)

### 4.EC2-RDS間の通信
- EC2上にMySQLクライアントをインストール済み
![mysql](images/9_connection.png)

- EC2からRDSへログインできることを確認
![connection](images/10_connection.png)
![showdb](images/11_connection.png)

