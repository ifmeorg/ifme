class CarePlanContactsController < ApplicationController
  include CarePlanContactsConcern

  def create
    care_plan_contact = CarePlanContact.new(care_plan_contact_params.merge(user_id: current_user.id))
    render json: create_response_object(care_plan_contact)
  end

  def update
    care_plan_contact = CarePlanContact.find_by(id: params[:id])
    render json: update_response_object(care_plan_contact)
  end

  def destroy
    care_plan_contact = CarePlanContact.find_by(id: params[:id])
    if care_plan_contact
      care_plan_contact.destroy
    end
    redirect_to_path(care_plan_path)
  end

  private

  def care_plan_contact_params
    params.require(:care_plan_contact).permit(:name, :phone)
  end
end
