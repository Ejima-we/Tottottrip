# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!( # ユーザーに見せる用のエラー出ないときはこちらの落ち度でエラーになっている可能性があるため、!をつけてエラー文を表示できるようにしている。
  email: 'admin@admin.com',
  password: 'adminadmin'
)
