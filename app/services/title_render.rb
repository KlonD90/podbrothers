class TitleRender
  def self.render(text)
    temp_file = Tempfile.new(['render_title_ru', '.png'])
    img = MiniMagick::Image.new(temp_file.path)

    img.run_command(:convert, "-background","#ee6e73","-fill","white",
                    "-font", Rails.application.config.font_path,   "-size", "1200x1200",
                    "-gravity", "Center", "-bordercolor", "#ee6e73", "-border", "200x50",
                    "caption:#{text.mb_chars.upcase.to_s}", temp_file.path)
    temp_file
  end
end