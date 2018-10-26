module ApplicationHelper
  def default_meta_tags
    {
      twitter: {
        url: "#{root_url}",
        image: "#{root_url.concat('assets/', 'top.png')}",
        card: 'summary_large_image',
        title: 'すかうったー',
        description: 'あなたの戦闘力を測ってみよう！'
      }
    }
  end
end
