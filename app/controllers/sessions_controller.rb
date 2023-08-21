class SessionsController < ApplicationController
  def new
  end
  
  #Sessionsコントローラのcreateアクション
  def create
    
    #ユーザーをデータベースから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      
      reset_session      # ログインの直前に必ずこれを書くこと
      remember user
      log_in user
      redirect_to user
      
    else
      #ログイン失敗時の処理(フラッシュメッセージ)
      #.now -----> 次のリクエストが来たら消えてください
      flash.now[:danger] = 'Invalid email/password combination' 
      
      # エラーメッセージを作成する
      render 'new', status: :unprocessable_entity
      
      #redirect : GET/users/1 => show template
      #render   :                render 'now' (0回)
    end
    
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
  
end
