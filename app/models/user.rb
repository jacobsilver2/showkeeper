class User < ApplicationController
  has_many :shows
  has_secure_password
end