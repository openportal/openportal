require 'faker'
require 'factory_girl'

FactoryGirl.define do
  factory :user do
    username "rhintz42"
    email "rhintz42@stanford.edu"
    password "a"
    password_confirmation "a"
    description "Cool person"
  end
end
