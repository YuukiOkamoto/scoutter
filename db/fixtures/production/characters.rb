Character.seed(
  :id,
  { id: 1, name: '農夫', introduction: '戦闘力5以下だと…ゴミめ。', minimum: 0, maximum: 5, growth_rate: 0.05, image_path: 'characters/noufu.png' },
  { id: 2, name: 'ミスターサタン', introduction: 'はっはー!!! 全世界のサタンファンの諸君!! おまたせーーーっ!!!', minimum: 6, maximum: 10, growth_rate: 0.05, image_path: 'characters/satan.png' },
  { id: 3, name: 'ビーデル', introduction: '私はミスターサタンの娘よ！', minimum: 11, maximum: 19, growth_rate: 0.05, image_path: 'characters/bidel.png' },
  { id: 4, name: '悟空(幼少期)', introduction: 'おめぇ強そうだな！', minimum: 20, maximum: 49, growth_rate: 0.05, image_path: 'characters/gokuu-child.png' },
  { id: 5, name: '亀仙人', introduction: 'これしきで満足するほど武の道は甘くないぞよ！ ほんとうの修行はこれからはじまるんじゃ', minimum: 50, maximum: 99, growth_rate: 0.05, image_path: 'characters/kamesennninn.png' },
  { id: 6, name: '桃白白', introduction: '世界一の殺し屋、桃白白だじょー', minimum: 100, maximum: 199, growth_rate: 0.1, image_path: 'characters/taopaipai.png' },
  { id: 7, name: 'チャオズ', introduction: 'さようなら天さん どうか 死なないで', minimum: 200, maximum: 299, growth_rate: 0.1, image_path: 'characters/chaoz.png' },
  { id: 8, name: 'ヤムチャ', introduction: 'きえろ　ぶっとばされんうちにな', minimum: 300, maximum: 499, growth_rate: 0.15, image_path: 'characters/yamucha.png' },
  { id: 9, name: '天津飯', introduction: 'チャオズ…カタキは討ってやるぞ…。そしてオレもいく……おまえだけにさびしいおもいはさせんぞ……。', minimum: 500, maximum: 799, growth_rate: 0.2, image_path: 'characters/tensinhan.png' },
  { id: 10, name: '栽培マン', introduction: 'ギ…!!!', minimum: 800, maximum: 1199, growth_rate: 0.25, image_path: 'characters/saibaiman.png' },
  { id: 11, name: 'クリリン', introduction: 'クリリンのことかーーーーーっ!!!!', minimum: 1200, maximum: 1799, growth_rate: 0.35, image_path: 'characters/kuririn.png' },
  { id: 12, name: '悟飯(幼少期)', introduction: 'おとうさんを…いじめるなーーーーー!!!', minimum: 1800, maximum: 2499, growth_rate: 0.4, image_path: 'characters/gohanchild.png' },
  { id: 13, name: 'ピッコロ', introduction: '地球を…なめるなよ……!!', minimum: 2500, maximum: 3499, growth_rate: 0.5, image_path: 'characters/pikkoro.png' },
  { id: 14, name: 'ナッパ', introduction: 'さあて…どいつからかたづけてやるかな…', minimum: 3500, maximum: 3999, growth_rate: 0.5, image_path: 'characters/nappa.png' },
  { id: 15, name: '悟空', introduction: 'オッス、オラ悟空！', minimum: 4000, maximum: 7999, growth_rate: 1, image_path: 'characters/gokuu.png' },
  { id: 16, name: 'ベジータ(初期)', introduction: 'へっ！きたねぇ花火だ', minimum: 8000, maximum: 19999, growth_rate: 2, image_path: 'characters/bejita.png' },
  { id: 17, name: '悟空(界王拳)', introduction: 'カラダもってくれよ!! 3倍界王拳だ!!!', minimum: 20000, maximum: 529999, growth_rate: 50, image_path: 'characters/gokuukaioken.png' },
  { id: 18, name: 'フリーザ(第一形態)', introduction: '私の戦闘力は53万です', minimum: 530000, maximum: 999999, growth_rate: 50, image_path: 'characters/furiza1.png' },
  { id: 19, name: 'フリーザ(第二形態)', introduction: '願いを叶えるのはこのフリーザさまだ！貴様ら下等生物なんかではなーーーい!!!!!', minimum: 1000000, maximum: 1499999, growth_rate: 50, image_path: 'characters/furiza2.png' },
  { id: 20, name: 'ピッコロ(ネイルと融合)', introduction: 'なんという力だ… 信じられんほどのすさまじい力が…!!!', minimum: 1500000, maximum: 2499999, growth_rate: 80, image_path: 'characters/pikkorofusion.png' },
  { id: 21, name: 'フリーザ(最終形態)', introduction: 'ふっふっふっふ……', minimum: 2500000, maximum: 99999999, growth_rate: 5000, image_path: 'characters/furiza4.png' },
  { id: 22, name: 'ベジータ(SS1)', introduction: 'オレは… 超ベジータだ!!!', minimum: 100000000, maximum: 199999999, growth_rate: 5000, image_path: 'characters/bejitasp1.png' },
  { id: 23, name: '悟空(SS1)', introduction: '超サイヤ人 孫悟空だ!!!!!!!', minimum: 200000000, maximum: 999999999, growth_rate: 30000, image_path: 'characters/gokuusp1.png' },
  { id: 24, name: 'セル', introduction: 'すでに地球どころか太陽系すべてが吹き飛ぶほどの気力がたまっているぞ!!!', minimum: 1000000000, maximum: 6999999999, growth_rate: 200000, image_path: 'characters/cell.png' },
  { id: 25, name: '悟飯(SS2)', introduction: 'もうゆるさないぞ おまえたち……', minimum: 7000000000, maximum: 19999999999, growth_rate: 350000, image_path: 'characters/gohansp2.png' },
  { id: 26, name: 'ベジータ(SS2)', introduction: 'がんばれカカロット… おまえがナンバー１だ!!', minimum: 20000000000, maximum: 29999999999, growth_rate: 350000, image_path: 'characters/bejitasp2.png' },
  { id: 27, name: '悟空(SS2)', introduction: '超サイヤ人を超えた超サイヤ人…', minimum: 30000000000, maximum: 39999999999, growth_rate: 350000, image_path: 'characters/gokuusp2.png' },
  { id: 28, name: '魔人ブウ(善)', introduction: 'チョコになっちゃえ!', minimum: 40000000000, maximum: 49999999999, growth_rate: 350000, image_path: 'characters/boo1.png' },
  { id: 29, name: '悟空(SS3)', introduction: '超サイヤ人を越えた超サイヤ人をもうひとつ越えてみるか…', minimum: 50000000000, maximum: 99999999999, growth_rate: 1000000, image_path: 'characters/gokuusp3.png' },
  { id: 30, name: 'ゴテンクス(SS3)', introduction: 'パンパカパーン!', minimum: 100000000000, maximum: 499999999999, growth_rate: 10000000, image_path: 'characters/gotenks.png' },
  { id: 31, name: '魔人ブウ(純粋)', introduction: 'ハァ〜〜〜ッ', minimum: 500000000000, maximum: 49999999999999, growth_rate: 1000000000, image_path: 'characters/boojunsui.png' },
  { id: 32, name: 'ベジット', introduction: 'こいつが超ベジット!!', minimum: 50000000000000, maximum: 499999999999999, growth_rate: 1000000000, image_path: 'characters/bejitto.png' },
  )
