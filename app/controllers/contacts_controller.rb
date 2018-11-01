class ContactsController < ApplicationController

  def create
    @contact = Contact.new(contact_params)
    if verify_recaptcha(model: @contact, response: contact_params[:response]) && @contact.valid?
      @contact.id = 1 # Appease ember serializer
      ContactMailer.new_contact(@contact).deliver_now
      render json: { contact: @contact.as_json }, status: :created
    else
      render json: { errors: @contact.errors }, status: :unprocessable_entity
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :message, :response)
    end

end
