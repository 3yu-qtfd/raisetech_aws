## 課題の回答

### 構成図
![configuration](images/1_configuration.png)

***

### デプロイの順序・詳細

#### 1.組み込みサーバー(Puma)だけでアプリを起動
- スクリプトで起動した場合 →3000番ポート指定でブラウザからアクセス可能
![puma-script](images/2_puma.png)
![puma-script-result](images/3_puma.png)

- systemdで起動した場合 →3000番ポート指定でブラウザからアクセス可能
![puma-systemd](images/4_puma.png)
![puma-systemd-result](images/5_puma.png)

#### 2.組み込みサーバー(Puma)＋Nginxでアプリを起動
- Pumaを起動
![puma-systemd](images/4_puma.png)

- localhost指定でNginxを起動 →80番ポート指定でブラウザからアクセス可能
![nginx](images/6_nginx.png)
![nginx-result](images/7_nginx.png)

#### 3.ALBを追加し、ALB経由でアプリへアクセス
- プロトコル:HTTP、ポート:80、アベイラビリティーゾーン:ap-northeast-1a、ap-northeast-1c
![alb-lb](images/8_alb.png)
![alb-target](images/9_alb.png)

- DNS名指定でNginxを起動 ※この画像ではDNS名指定での起動設定に変更後、Nginxを再起動しています
![alb](images/10_alb.png)
![alb-result](images/11_alb.png)

#### 5.S3を追加し、アプリ上で登録した画像をS3へ保存
- S3へのパブリックアクセスはブロックし、EC2にIAMロールを付与
![s3](images/12_s3.png)

- 画像がS3に保存されていることを確認
![s3-result](images/13_s3.png)

