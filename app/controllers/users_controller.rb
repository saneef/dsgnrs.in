class UsersController < ApplicationController
  # GET /users
  def index
    city ||= params[:city]

    if city
      not_found
    else
      @users = User.where(:is_approved => true)
    end
  end

  # GET /users/1
  def show
    if current_user && current_user.is_admin?
      redirect_to action: "edit"
    else
      not_found
    end
  end

  # GET /users/new
  def new
    unless current_user
      not_found
    end
  end

  # GET /users/1/edit
  def edit
    unless current_user
      session[:return_to] ||= request.fullpath
      redirect_to '/auth/twitter'
    end

    @user = current_user
    if params[:id]
      if current_user.is_admin?
        @user = User.find(params[:id])
      else
        not_found
      end
    end
  end

  # POST /users
  def create
  end

  # PUT /users/1
  def update
    unless current_user
      permission_denied
    end

    @user = User.find(params[:id])

    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.url = params[:user][:url]
    @user.company = params[:user][:company]
    @user.company_url = params[:user][:company_url]

    if @user.valid?
      @user.save
      flash[:success] = 'Profile Saved Successfully'
      redirect_to root_path
    else
      render action: "edit"
    end
  end

  # DELETE /users/1
  def destroy
  end
end
