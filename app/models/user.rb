class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable,
  #       :recoverable, :rememberable, :trackable, :validatable

  #removed registerable from devise
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
end
