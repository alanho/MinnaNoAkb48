# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song do
    name_jp "MyString"
    name_romaji "MyString"
    name_en "MyString"
    lyric_jp "MyText"
    lyric_romaji "MyText"
    lyric_en "MyText"
  end
end
