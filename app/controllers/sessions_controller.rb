class SessionsController < ApplicationController
  def new
  end
  
  #Sessionsコントローラのcreateアクション
  def create
    
    #ユーザーをデータベースから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      #Success
      #log_in(@user)
      
      reset_session      # ログインの直前に必ずこれを書くこと
      log_in user
      redirect_to user
      
    else
      #ログイン失敗時の処理(フラッシュメッセージ)
      #Failure-----> alert-danger => 赤色のフラッシュ
      #.now -----> 次のリクエストが来たら消えてください
      flash.now[:danger] = 'Invalid email/password combination' 
      
      # エラーメッセージを作成する
      render 'new', status: :unprocessable_entity
      
      #redirect_to vs. render
      #GET/users/1 => show template
      #               render 'now' (0回)
    end
    
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
  
end
