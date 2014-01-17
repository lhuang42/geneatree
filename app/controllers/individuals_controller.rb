class IndividualsController < ApplicationController
  
  def new
  end
  
  def create
    @tree = Tree.find(params[:tree_id])
    @individual = @tree.individuals.create(individual_params)
    
    if @tree.individuals.count == 1
      @individual.generation = 0
      @individual.blood = true
      @individual.direct = true
      @individual.save!
    end
    
    if params[:connection_type].present?
      @connected = Individual.find(params[:connected_id])
      if params[:connection_type] == "1"
        @connected.update_child_with_new_parent(@individual)
      elsif params[:connection_type] == "2"
        @connected.update_new_child(@individual)
      end
    end
    
    if @tree.oldest_gen <= @individual.generation
      @tree.update_attribute(:oldest_gen, @individual.generation)
    end    
    redirect_to tree_path(@tree)
  end
  
  def add_connection
    @individual = Individual.new
    @pass = params
    
    respond_to do |format|  
      format.html
      format.js
    end
  end
  
  def update
    @tree = Tree.find(params[:tree_id])
    set_individual
    @individual.update(individual_params)
    redirect_to tree_path(@tree)
  end
  
  def destroy
    set_individual
    @individual.destroy
    respond_to do |format|
      format.html { redirect_to tree_path(@tree) }
      format.json { head :no_content }
    end
  end
  
  private
  
    def set_tree
      @tree = Tree.find(params[:tree_id])
    end
  
    def set_individual
      @individual = Individual.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def individual_params
      params.require(:individual).permit(:name)
    end  
end
