module CoursesHelper
  def add_session_link(name, f) 
    link_to_function name do |page|
      page << %q{
        (function(){
          var sessions = $('#session .session');
          var template = sessions[sessions.length-1];
          var clone = template.cloneNode(true);
          template.parentNode.appendChild(clone)
          var elements = clone.getElementsByTagName('*')
          $(elements).each(function(index,element){
            if(element.name){
              element.name = element.name.replace(/(course\[sessions_attributes\]\[)(\d+)(\])/,function(str,start,num,end){ return start + (parseInt(num)+1) + end })
            }
          })
        })()
      }
    end
  end  
end
