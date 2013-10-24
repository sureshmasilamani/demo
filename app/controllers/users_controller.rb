#require 'will_paginate/array'
require 'line'
class UsersController < ApplicationController
  
  before_filter :authenticate

  def authenticate
   # if Rails.env.production?
     # authenticate_or_request_with_http_basic do |username, password|
     #   username == "suresh" && password == "sureshm"
     # end 
   # end
  end
  # GET /users
  # GET /users.xml
  def index
   p = Person.new(:first_name => "Yukihiro", :last_name => "Matsumoto")
    raise p.attributes.inspect
    #@users = User.all
    #@users = User.all.paginate :per_page => 5, :page => params[:page] ,:order => 'id'
      @users = User.order("name").page(params[:page]).per(5)
    #raise params[:page].inspect
    #@users = User.all.paginate(:page => params[:page], :per_page => 50)
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @users_name }
    #end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @services = {}
    @all_service_groups = User.find(:all)
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])    
  #  User.skip_callback(:before_save) { @user.save! } 
   User.skip_callback(:before_save) do
   respond_to do |format|  
    if @user.save  
      UserMailer.registration_confirmation(@user).deliver  
      format.html { redirect_to(@user, :notice => 'User was successfully created.') }  
      format.xml  { render :xml => @user, :status => :created, :location => @user }  
    else  
      format.html { render :action => "new" }  
      format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }  
    end          
  end
  end  
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
def load_services
  render :layout => false
end
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  def remote
  end
end
