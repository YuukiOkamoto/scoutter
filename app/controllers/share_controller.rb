class ShareController < ApplicationController
  def twitter
    @user = User.find(params[:id])
    tweet_url = URI.encode(
        "http://twitter.com/intent/tweet?" +
            "&text=" +
            "わたしのTwitter戦闘力は…【 #{@user.get_sum_powers(:total).to_j} 】!!!\nこの戦闘力から導き出されたキャラクターは…【 #{@user.character_name} 】!!!\n" +
            "毎日測ってTwitter戦闘力を上げていこう!!!\n" +
            "#Scoutter\n#Twitter戦闘力\n" +
            "&url=" +
            "#{view_context.root_url}"
    )
    redirect_to tweet_url
  end
end
