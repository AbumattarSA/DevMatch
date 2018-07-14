class ContactsController < ApplicationController
    def new
      @contact = Contact.new
    end
    
    def create
      @contact = Contact.new(contact_params)
      
      if @contact.save
        redirect_to new_contact_path, notice: "Your form has been sent."
      else
        redirect_to new_contact_path, notice: "An unknown error has occured."
      end
    end
    
    private
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end