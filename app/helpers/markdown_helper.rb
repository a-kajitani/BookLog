module MarkdownHelper
  # RedcarpetとRedcarpet::Render::Stripを読み込む
  require 'redcarpet'

  # マークダウン形式のテキストをHTMLに変換するメソッド
  def markdown(text)
    
    return "".html_safe if text.blank?
      # 文字列化＋UTF-8 正規化（不正バイトは置換）
      s = text.to_s
    unless s.encoding == Encoding::UTF_8 && s.valid_encoding?
      s = s.encode("UTF-8", invalid: :replace, undef: :replace, replace: "�")
    end
    # レンダリングのオプションを設定する
    render_options = {
      filter_html:     true,  # HTMLタグのフィルタリングを有効にする
      hard_wrap:       true,  # ハードラップを有効にする
      link_attributes: { rel: 'nofollow', target: "_blank" },  # リンクの属性を設定する
      escape_html:        true, # xss対策 全てのHTMLタグをエスケープ(filter_htmlより優先) 
    }

    # HTMLレンダラーを作成する
    renderer = Redcarpet::Render::HTML.new(render_options)

    # マークダウンの拡張機能を設定する
    extensions = {
      space_after_headers: true,  # ヘッダー後のスペースを有効にする
      autolink:           true,  # 自動リンクを有効にする
      no_intra_emphasis:  true,  # 単語内の強調を無効にする
      fenced_code_blocks: true,  # フェンス付きコードブロックを有効にする
      lax_spacing:        true,  # 緩いスペーシングを有効にする
      strikethrough:      true,  # 取り消し線を有効にする
      superscript:        true  # 上付き文字を有効にする
    }

    # マークダウンをHTMLに変換し、結果をhtml_safeにする
    Redcarpet::Markdown.new(renderer, extensions).render(s).html_safe
  end
end
