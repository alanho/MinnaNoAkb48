# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vocabulary do
    kanji "MyString"
    furigana "MyString"
    romaji "MyString"
    meaning "MyString"
    level "MyString"
  end
end
