module ApplicationHelper
  def default_meta_tags
    {
      og: {
        image: "#{asset_url('top.png')}"
      },
      twitter: {
        url: "#{root_url}",
        image: "#{asset_url('top.png')}",
        card: 'summary_large_image',
        title: 'Scoutter',
        description: 'あなたの戦闘力を測ってみよう！'
      }
    }
  end
end
