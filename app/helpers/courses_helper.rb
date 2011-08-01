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
              var el = $(template).find('select[id*="starts_at"]');
              var date = new Date($(el[2]).val(),$(el[1]).val()-1,$(el[0]).val(),$(el[3]).val(),$(el[4]).val());
              date.setDate(date.getDate()+7);
              var clone_el = $(clone).find('select[id*="starts_at"]');
              $(clone_el[2]).val(date.getFullYear());
              $(clone_el[1]).val(date.getMonth()+1);
              $(clone_el[0]).val(date.getDate());
              // Needs to always be two digits long
              //$(clone_el[3]).val(date.getHours());
              //$(clone_el[4]).val(date.getMinutes());
            }
          })
        })()
      }
    end
  end  
end

