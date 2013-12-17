module RDiaLib
  module CommentHelper

    def prepare_comment_above(title)
      comment_text_above + title
    end

    def prepare_comment_below(title)
      comment_text_below + title
    end



    def comment_spacer()
      '###'
    end

    def comment_text()
      comment_spacer + ' DO NOT EDIT '
    end

    def comment_text_above()
      comment_text() + 'BELOW '
    end

    def comment_text_below()
      comment_text() + 'ABOVE '
    end  

  end
end
