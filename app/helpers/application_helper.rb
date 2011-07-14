module ApplicationHelper

  def section_sortable
    %Q{
      <script type="text/javascript">
        $(document).ready(function() {
          $('#sortable').sortable( {
            dropOnEmpty: false,
            cursor: 'crosshair',
            opacity: 0.75,
            scroll: true,
            items: 'section',
            update: function() {
              $.ajax( {
                type:     'post',
                data:     $('#sortable').sortable('serialize'),
                dataType: 'script',
                url:      '#{sort_sections_path}'
                } )
              }
            });
          });
      </script>
    }.gsub(/[\n ]+/, ' ').strip.html_safe
  end

end
