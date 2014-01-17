class TreesController < ApplicationController
  before_action :set_tree, only: [:show, :edit, :update, :destroy, :render_tree]
  before_filter :authenticate_user!

  # GET /trees
  # GET /trees.json
  def index
    @user = current_user
    @trees = @user.trees
  end

  # GET /trees/1
  # GET /trees/1.json
  def show
    @ind_ordered = @tree.individuals_ordered if @tree.individuals.present?
    respond_to do |format|  
      format.html
      format.js
    end
  end

  # GET /trees/new
  def new
    @tree = Tree.new
  end

  # GET /trees/1/edit
  def edit
  end

  # POST /trees
  # POST /trees.json
  def create
    @tree = Tree.new(tree_params)
    @tree.user = current_user
    @tree.oldest_gen = 0

    respond_to do |format|
      if @tree.save
        format.html { redirect_to @tree, notice: 'Tree was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tree }
      else
        format.html { render action: 'new' }
        format.json { render json: @tree.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trees/1
  # PATCH/PUT /trees/1.json
  def update
    respond_to do |format|
      if @tree.update(tree_params)
        format.html { redirect_to @tree, notice: 'Tree was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tree.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /trees/1
  # DELETE /trees/1.json
  def destroy
    @tree.destroy
    respond_to do |format|
      format.html { redirect_to trees_url }
      format.json { head :no_content }
    end
  end
  
  def form
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def render_tree
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tree
      @tree = Tree.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tree_params
      params.require(:tree).permit(:title)
    end
end
