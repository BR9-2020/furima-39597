# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| email              | string  | null: false, unique: true |
| nickname           | string  | null: false               |
| encrypted_password | string  | null: false               |
| name               | string  | null: false               |
| kana_name          | string  | null: false               |
| birth_year         | integer | null: false               |
| birth_month        | integer | null: false               |
| birth_day          | integer | null: false               |

### Association
- has_many :items
- has_many :purchases

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| seller           | references | null: false, foreign_key: true |
| item_name        | string     | null: false                    |
| item_description | text       | null: false                    |
| category         | string     | null: false                    |
| condition        | string     | null: false                    |
| shipping_cost    | string     | null: false                    |
| shipping_region  | string     | null: false                    |
| shipping_days    | string     | null: false                    |
| price            | integer    | null: false                    |

### Association
- belongs_to :users
- has_one :purchases

## purchases テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| buyer       | references | null: false, foreign_key: true |
| bought_item | references | null: false, foreign_key: true |

### Association
- belongs_to :items
- belongs_to :users
- has_one :shipments

## shipments テーブル

| Column            | Type   | Options     |
| ----------------- | ------ | ----------- |
| postcode          | string | null: false |
| prefecture        | string | null: false |
| city_town_village | string | null: false |
| street_address    | string | null: false |
| phone_number      | string | null: false |

### Association
- belongs_to :purchases