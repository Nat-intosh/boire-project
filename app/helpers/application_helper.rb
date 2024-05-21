module ApplicationHelper
    def emoji_for_card_type(card_type)
        case card_type
        when 'hot'
          '🌶️'
        when 'drink'
          '🍻'
        when 'defi'
          '🎲'
        when 'gametime'
          '▶'
        else
          '🍻' # Default emoji for unknown card types
        end
      end
end
