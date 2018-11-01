module ApplicationHelper
  def default_meta_tags
    {
      og: {
        site_name: 'Scoutter',
        description: 'あなたの戦闘力を測ってみよう！',
        'format-detection' => 'telephone=no,address=no,email=no',
        image: "#{asset_url('top.png')}",
        url: "#{root_url}",
      },
      twitter: {
        card: 'summary_large_image',
        site: '@team_scoutter',
        player: '@team_scoutter',
      }
    }
  end
end
