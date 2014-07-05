class CategoriesController < ApplicationController

  before_action :test_login

  def show
    @category = Category.find params[:id]
  end
end