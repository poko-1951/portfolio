module ApplicationHelper
  def default_meta_tags
    {
      site: "- いつまでも、絶え間ない会話を -",
      title: "Convrce",
      reverse: true,
      separator: " ",
      description: "『Converce』は会話が苦手なあなたに、話題(Conversation piece)を提供するサービスです。",
      keywords: "会話,話題,苦手,思い浮かばない,気まずい,conversation piece, converce",
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url("favicon.ico") },
        # { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: "Converce",
        title: "Converce",
        description: "『Converce』は会話が苦手なあなたに、話題(Conversation piece)を提供するサービスです。",
        type: "website",
        url: request.original_url,
        # image: image_url('ogp.png'),
        locale: "ja_JP",
      },
      twitter: {
        card: "summary_large_image",
        site: "@ツイッターのアカウント名",
      }
    }
  end
end
