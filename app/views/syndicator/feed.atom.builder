atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated

  @users.each do |user|
    feed.entry(user) do |entry|
      entry.url "#{url_for(:controller => 'users', :only_path => false)}\#designer-#{user.id}"
      entry.title "#{user.name}(@#{user.nickname}) just got listed"
      entry.content "#{user.name}(@#{user.nickname}) just got listed"

      entry.updated user.created_at.to_s(:rfc822)
    end
  end
end