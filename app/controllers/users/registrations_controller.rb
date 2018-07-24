class Users::RegistrationsController < Devise::RegistrationsController
   # Extend default Devise gem behaviour so that pro users (ID: 2) save with a
   # special Stripe subscription function. Otherwise, regular registration.
    def create
        super do |resource|
            if params[:plan]
                resource.plan_id = params[:plan]
                if  resource.plan_id == 2
                    resource.save_with_subscription
                else
                    resource.save
                end
            end
        end
    end
end