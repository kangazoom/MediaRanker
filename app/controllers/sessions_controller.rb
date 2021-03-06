class SessionsController < ApplicationController
  def new
    @user = User.new()
  end

  def create
    username = params[:username]
    @user = User.find_by(username: username)

    if @user
      flash[:success] = "Successfuly logged in as existing user #{username}"

      user_success_plus_redirect()
      # session[:user_id] = @user.id
      # redirect_to root_path
    else
      # if user not found, create a new one
      @user = User.new(username: username)
      result = @user.save
      # if/else depending on successful save
      if result
        flash[:success] = "Successfully created new user #{username} with ID #{@user.id}"

        user_success_plus_redirect()
        # session[:user_id] = @user.id
        # redirect_to root_path
      else
        #TODO: fix flash alerts; render???
        flash[:alert] = @user.errors.messages
        redirect_to new_login_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def user_success_plus_redirect
    session[:user_id] = @user.id
    redirect_to root_path
  end

end
