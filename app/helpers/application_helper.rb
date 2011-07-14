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

  def photo_uploadify
  #   # Putting the uploadify trigger script in the helper gives us
  #   # full access to the view and native rails objects without having
  #   # to set javascript variables.
  #   #
  #   # Uploadify is only a queue manager to hand carrierwave the files
  #   # one at a time. Carrierwave handles capturing, resizing and saving
  #   # all uploads. All limits set here (file types, size limit) are to
  #   # help the user pick the right files. Carrierwave is responsible
  #   # for enforcing the limits (white list file name, setting maximum file sizes)
  #   #
  #   # ScriptData:
  #   #   Sets the http headers to accept javascript plus adds
  #   #   the session key and authenticity token for XSS protection.
  #   #   The "FlashSessionCookieMiddleware" rack module deconstructs these
  #   #   parameters into something Rails will actually use.

    key = Rails.application.config.session_options[:key]
    %Q{

      <script type='text/javascript'>
        $(document).ready(function() {
          var upload_params = {
            '#{key}'              : encodeURIComponent("#{ u(cookies[key]) }"),
            'authenticity_token'  : encodeURIComponent("#{ u(form_authenticity_token) }"),
            '_http_accept'        : 'application/javascript'
          };
          var url = $('input#photo_image').attr('rel');
          var uploader_path = "#{asset_path('javascripts/uploadify/uploadify.swf')}"
          $('input#photo_image').uploadify({
            'uploader'     : uploader_path,
            'script'       : url,
            'fileDataName' : 'photo[image]',
            'fileExt'      : '*.png;*.jpg;*.gif',
            'cancelImg'    : "#{asset_path('cancel.png')}",
            'multi'        : true,
            'auto'         : true,
            'buttonText'   : 'Add Photos',
            'scriptData'   : upload_params
          });
        });
      </script>
    }.gsub(/[\n ]+/, ' ').strip.html_safe

     # 'title'               : "#{@post.title}",
     #        'user_id'             : "#{current_admin.id if current_admin}"

    # 'onComplete'   : function(e, id, obj, response, data) {
    #   $('#images').append(response);
    # }
  end
end
