module AdUnitsHelper
  def class_type(status)
    case status 
    when -1 
      return "label label-danger"
    when 0 
 	    return "label label-primary"
 	  when 1 
 	    return "label label-info"
 	  when 2 
	    return "label label-success"
 	  end  
  end

  def ad_unit_status_info(status)
    case status 
    when -1 
      return "Error"
    when 0 
 	    return "Not created"
    when 1 
 	    return " In progress" 
 	  when 2 
	    return "Created"
 	  end  
  end

   def account_status_info(status)
     case status
     when -1
      return "Error"
     when 0
       return "Not synhronized"
     when 1
       return "In progress"
     when 2
       return "Synhronized"
     end
  end
end
