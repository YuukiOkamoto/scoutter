module ApplicationHelper
  def default_meta_tags
    {
      twitter: {
        image: "",
        card: 'summary_large_image',
        # twitter cardのタイトルと本文は固定？
        title: 'すかうったー',
        description: 'Twitterでのあなたの戦闘力は??'
      }
    }
  end
end
