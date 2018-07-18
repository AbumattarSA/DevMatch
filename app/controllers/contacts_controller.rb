class ContactsController < ApplicationController
  
    # GET request to /contact-us
    # Shows new contact form
    def new
      @contact = Contact.new
    end
    
    # POST request to /contacts
    def create
      # Mass assignment of form fields into the Contact object
      @contact = Contact.new(contact_params)
      # Saves the Contact object to the database
      if @contact.save
        # Stores form fields via parameters to local variables
        name = params[:contact][:name]
        email = params[:contact][:email]
        body = params[:contact][:comments]
        # Plugs variables into ContactMailer email method and sends email
        ContactMailer.contact_email(name, email, body).deliver
        # Stores success message in the flash hash and redirects to 'new' action
        flash[:success] = "Your form has been sent."
        redirect_to new_contact_path
      else
        # If the Contact object does not save, stores error in flash hash and
        # redirects to the 'new' action
        flash[:danger] = @contact.errors.full_messages.join(", ")
        redirect_to new_contact_path
        
      end
    end
    
    private
    # Strong parameters to allow data collection from form and whitelists
    # the form fields
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end