module ApplicationHelper

    def flash_class(level)
        case level
            when :notice then 'alert alert-success'
            when :alert then 'alert alert-danger'    
        end
    end

    # def resource_name
    #     :user
    #   end
    
    #   def resource
    #     @resource ||= User.new
    #   end
    
    #   def devise_mapping
    #     @devise_mapping ||= Devise.mappings[:user]
    #   end
    
end
