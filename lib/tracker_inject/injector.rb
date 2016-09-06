  class Injector

    module Filter
      extend ActiveSupport::Concern
      included do
        append_after_filter :add_script

        CLOSING_BODY_TAG = %r{</body>}

        def add_script
          response.body = response.body.gsub(CLOSING_BODY_TAG, "<script>
            var trackingCode = function() {

              !function(g,s,q,r,d){r=g[r]=g[r]||function(){(r.q=r.q||[]).push(
                arguments)};d=s.createElement(q);q=s.getElementsByTagName(q)[0];
          d.src='//d1l6p2sc9645hc.cloudfront.net/tracker.js';q.parentNode.
          insertBefore(d,q)}(window,document,'script','_gs');
          _gs('#{GoSquared.configure.site_token}'); _gs('set', 'trackLocal', true);
          };

          var loadTracker;
          loadTracker=function(){
            if(!window._gs) {
              trackingCode();
              } else {
                delete _gs;
                trackingCode();
              }
              };
              $(document).on('page:load', loadTracker)
              $(document).on('turbolinks:load', loadTracker);
              </script>" + "\n </body>")

        end

      end
    end

  end
