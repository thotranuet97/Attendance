class TotalController < ApplicationController
    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def total
        @user = User.find_by(id: params[:user_id])
    end

    
end
