class MyFormBuilder < ActionView::Helpers::FormBuilder
  def text_field(method, options={})
    errors = object.errors[method.to_sym]
    if errors
      options[:placeholder] = errors.first
    end
    super(method, options)
  end

  def password_field(method, options={})
    errors = object.errors[method.to_sym]
    if errors
      options[:placeholder] = errors.first
    end
    super(method, options)
  end

  def email_field(method, options={})
    errors = object.errors[method.to_sym]
    if errors
      options[:placeholder] = errors.first
    end
    super(method, options)
  end

end