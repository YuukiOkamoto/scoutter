class UserDecorator < Draper::Decorator
  delegate_all

  def icon_url(version = :origin)
    if !icon.attached? || icon.metadata.blank?
      return 'icon.png'
    end

    command =
      case version
      when :thumb
        { resize: '640x480' }
      when :icon
        metadata = avatar.metadata
        square(160, metadata[:width], metadata[:height])
      else
        false
      end
    (command ? icon.variant(command).processed : icon).service_url(expires_in: 100.years)

    private

    def square(size, width, height)
      shave =
        if width < height
          remove = ((height - width) / 2).round
          "0x#{remove}"
        else
          remove = ((width - height) / 2).round
          "#{remove}x0"
        end

      {
        shave: shave,
        resize: "#{size}x#{size}"
      }
    end
  end
end
