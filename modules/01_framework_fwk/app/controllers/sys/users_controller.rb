class Sys::UsersController < ApplicationController
  before_action :set_sys_user, only: [:show, :edit, :update, :destroy]

  # GET /sys/users
  # GET /sys/users.json
  def index
    @sys_users = Sys::User.all
  end

  # GET /sys/users/1
  # GET /sys/users/1.json
  def show
  end

  # GET /sys/users/new
  def new
    @sys_user = Sys::User.new
  end

  # GET /sys/users/1/edit
  def edit
  end

  # POST /sys/users
  # POST /sys/users.json
  def create
    @sys_user = Sys::User.new(sys_user_params)

    respond_to do |format|
      if @sys_user.save
        format.html { redirect_to @sys_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @sys_user }
      else
        format.html { render :new }
        format.json { render json: @sys_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sys/users/1
  # PATCH/PUT /sys/users/1.json
  def update
    respond_to do |format|
      if @sys_user.update(sys_user_params)
        format.html { redirect_to @sys_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @sys_user }
      else
        format.html { render :edit }
        format.json { render json: @sys_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sys/users/1
  # DELETE /sys/users/1.json
  def destroy
    @sys_user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sys_user
      @sys_user = Sys::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sys_user_params
      params.require(:sys_user).permit(:login_name, :first_name, :last_name, :full_name, :email, :phone, :locked_flag, :locked_time, :locked_until_at, :last_login_at, :status)
    end
end
