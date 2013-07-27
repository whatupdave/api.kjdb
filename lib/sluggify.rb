class String
  def sluggify
    self.to_slug.normalize.to_s
  end
end