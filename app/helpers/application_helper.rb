module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Loop"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def linkify_hashtags(hashtaggable_content)
  regex = SimpleHashtag::Hashtag::HASHTAG_REGEX
  hashtagged_content = hashtaggable_content.to_s.gsub(regex) do
    #raw("<a onclick=\"document.getElementById(\'searcher\').value=\'" + $2 + "\'; $.get(\'micropost_search/?search=" + $2 "\');\" style=\"cursor:pointer;\">" + $2 + "</a>")
    #link_to $&, $2, :onclick=>"document.getElementById('searcher').value='".html_safe + $2 + "'; $.get('micropost_search/?search=".html_safe + $2 + "');".html_safe
    #"<a onclick=\"test\">".html_safe + $2
    " <a onclick=\"document.getElementById('searcher').value='" + $2 + "'; $.get('micropost_search/?search=" +$2+ "');\" style=\"cursor:pointer;\">" + $1 + "</a>"

  end
  hashtagged_content.html_safe
	end

  def linkify_hashtags_within(hashtaggable_content)
  regex = SimpleHashtag::Hashtag::HASHTAG_REGEX
  hashtagged_content = hashtaggable_content.to_s.gsub(regex) do
    #raw("<a onclick=\"document.getElementById(\'searcher\').value=\'" + $2 + "\'; $.get(\'micropost_search/?search=" + $2 "\');\" style=\"cursor:pointer;\">" + $2 + "</a>")
    #link_to $&, $2, :onclick=>"document.getElementById('searcher').value='".html_safe + $2 + "'; $.get('micropost_search/?search=".html_safe + $2 + "');".html_safe
    #"<a onclick=\"test\">".html_safe + $2
    " <a href=\"../?search=" + $2 + "\"\>".html_safe + $1 + "</a>".html_safe

  end
  hashtagged_content.html_safe
  end

end
