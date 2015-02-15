module ApplicationHelper
    # Returns the full title on a per-page basis.
    def full_title(page_title = '')
        base_title = "GoAround | Compare.Request.Ride"
        if page_title.empty?
            base_title
        else
            "GoAround - #{page_title} | Compare.Request.Ride"
        end
    end
end
