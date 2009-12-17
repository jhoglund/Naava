module TextHelper

  def truncate_size(text, i, o='...')
    return if text.nil?
    size = (text[0, i+1] =~ /\s(?!.*\s)/)
    unless size.nil?
      size + o.length - 1
    else
      lenght
    end
  end

end