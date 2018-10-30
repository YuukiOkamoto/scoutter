module MyKaminari
  def forward_page?(current_page)
    current_page <= 2 + Kaminari.config.window
  end

  def backward_page?(current_page, total_pages)
    current_page + 1 >= total_pages - Kaminari.config.window
  end

  module_function :forward_page?, :backward_page?
end
