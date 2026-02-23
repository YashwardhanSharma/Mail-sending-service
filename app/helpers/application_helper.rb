module ApplicationHelper
    def bootstrap_class_for(flash_type)
        case flash_type.to_sym
        when :notice
            "alert-success"
        when :alert
            "alert-danger"
        else
            "alert-info"
        end
    end
end
