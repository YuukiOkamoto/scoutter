module ApplicationHelper
  def default_meta_tags
    {
      twitter: {
        url: "#{root_url}",
        image: "#{asset_url('top.png')}",
        card: 'summary_large_image',
        title: 'スカウッター',
        description: 'あなたの戦闘力を測ってみよう！'
      }
    }
  end
end
