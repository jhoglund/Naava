module AttendantsHelper
  def add_participant_link(name, f) 
    include_inline_resource :participant_link do
      %q{
        var add_participant_link = function(){
          var participants = $('#participants');
          var clone = participants.find('li:last').clone()
          participants.append(clone)
          clone.find(':input[name$="\[participant_id\]"]').remove();
          clone.find(':input').each(function(i,element){
            element.name = element.name.replace(/(session\[attendants_attributes\]\[)(\d+)(\])/,function(str,start,num,end){ return start + (parseInt(num)+1) + end })
          })
          clone.find(':checkbox').each(function(i,element){
            element.checked = true
          })
          clone.find('label').each(function(i, element){
            var name = clone.find(':input:first').attr('name').replace(/status/, 'participant_attributes');
            $(element).replaceWith('<input name="'+name+'[name]"/>');
          })
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
          
        }
      }
      
    end
    link_to_function name do |page|
      page << %q{add_participant_link()}
    end
  end  
  
end
