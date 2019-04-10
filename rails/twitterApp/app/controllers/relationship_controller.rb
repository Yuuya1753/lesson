class RelationshipController < ApplicationController
  def create
    @relationship = Relationship.new(relationship_params)

    respond_to do |format|
      if @relationship.save
        format.html { redirect_to controller: :home, action: :index }
        format.json { render :show, status: :created, location: @relationship }
      else
        format.html { render :new }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def relationship_params
    params.require(:relationship).permit(:follower_id, :followee_id)
  end
end
