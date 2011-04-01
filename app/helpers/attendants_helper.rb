module AttendantsHelper
  
  def add_participant_link(name, f, session)
    include_inline_resource :participant_payment_options do
      %q{
        var participant_payment_options = function(select){
          var name = $(select).attr('name');
          var options = $(document.getElementById(name + "_options"));
          options.children().hide();
          var newElement = document.getElementById(name + "_" + $(select).val());
          if(newElement){
            $(newElement).show().find(':input').focus();
          }
        }
      }
    end
    
    include_inline_resource :participant_link_payment_form do
      %Q{
        var bookingIndex = 0;
        var participant_form = "#{ escape_javascript(render( :partial => '/admin/attendants/new_attendant', :locals => { :session => session })) }"
      }
    end
    include_inline_resource :participant_link do
      %q{
        var add_participant_link = function(){
          var updateName = function(str){
            return str.replace(/(session\[bookings_attributes\]\[)(\d+)(\])/igm,function(str,start,num,end){ return start + bookingIndex + end })
          }
          var updateId = function(str){
            return str.replace(/(participant_index_)(\d+)(_)/igm,function(str,start,num,end){ return start + bookingIndex + end })
          }
          
          var clone = $(updateId(updateName(participant_form))).appendTo(participants)
          
          clone.find(':input:text').each(function(i, element){
            var input = $(element);
            input.val('');
            input.autocomplete(autocomplete);
            input.keydown(function(e){
              if(e.keyCode==9){
                add_participant_link();
                return false;
              }
            })
            input.focus();
          })
          bookingIndex++
        }
      }
      
    end
    link_to_function name do |page|
      page << %q{add_participant_link()}
    end
  end  
  
end
