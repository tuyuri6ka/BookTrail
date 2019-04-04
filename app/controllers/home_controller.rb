class HomeController < ApplicationController
  #ログイン時のアクセスを制限する
  before_action :forbid_login_user,{only: [:top]}

  def top
  end

  def about
  end
end
