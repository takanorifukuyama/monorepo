@startuml
left to right direction
actor ユーザー
rectangle {
   ユーザー --> (ログイン)
   ユーザー --> (パスワード設定)
   ユーザー --> (登録)
}
actor 管理者
rectangle {
   管理者 --> (登録者を検索)
   管理者 --> (登録を承認)
   管理者 --> (ユーザーグループ管理)
   管理者 --> (権限の確認)
   管理者 --> (アカウント削除)
}
@enduml
