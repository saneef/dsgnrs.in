class UsersController < ApplicationController
  # GET /users
  def index
    query_user_status = true
    if current_user && current_user.is_admin? && params[:status]
      query_user_status = case params[:status]
                          when 'approved' then true
                          when 'rejected' then false
                          when 'waiting' then nil #If admin take no action.
                          else nil
                          end
    elsif params[:status] && current_user && (not current_user.is_admin?)
        not_found
    end

    if params[:city]
      @city = City.where(:slug => params[:city]).first
      logger.debug "Listings from: #{@city.name}" if @city

      if @city
        @users = @city.users.all_with_approval_status query_user_status
      else
        not_found
      end
    else
      @users = User.all_with_approval_status query_user_status
    end
  end

  # GET /users/1
  def show
    if current_user && current_user.is_admin?
      redirect_to action: "edit"
    else
      redirect_to "#{root_path}\#designer-#{params[:id]}"
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

    profile_save_msg = 'Profile Saved Successfully';

    @user = User.find(params[:id])

    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.url = params[:user][:url]
    @user.company = params[:user][:company]
    @user.company_url = params[:user][:company_url]
    @user.city_virtual = params[:user][:city_virtual]

    if (@user.is_approved? != true) && (not current_user.is_admin?)
      profile_save_msg = "Thanks for applying. We will list the profile after a quick check, very soon.";
    end

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
      flash[:success] = profile_save_msg
      redirect_to root_path
    else
      render action: "edit"
    end
  end

  # DELETE /users/1
  def destroy
  end
end
