class UsersController < ApplicationController
  # GET /users
  def index
    if params[:city]
      @city = City.where(:slug => params[:city]).first
      logger.debug "Listings from: #{@city.name}"

      if @city
        @users = @city.users.find(
          :all,
          :conditions => { :is_approved => true },
          :order => 'LOWER(name)'
        )
      else
        not_found
      end
    else
      @users = User.find(
        :all,
        :conditions => { :is_approved => true },
        :order => 'LOWER(name)'
      )
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
    @user.city_virtual = @user.city.name if @user && @user.city
  end

  # POST /users
  def create
  end

  # PUT /users/1
  def update
    if current_user.nil?
      permission_denied
    end

    @user = User.find(params[:id])

    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.url = params[:user][:url]
    @user.company = params[:user][:company]
    @user.company_url = params[:user][:company_url]
    @user.city_virtual = params[:user][:city_virtual]

    if current_user.is_admin?
      @user.is_approved = params[:user][:is_approved]
    end

    if @user.valid?
      city = City.where(:name => @user.city_virtual).first
      if city
        @user.city = city
      else
        @user.create_city :name=> @user.city_virtual
      end

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
