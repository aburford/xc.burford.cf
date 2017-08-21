class MemberView

  def setup
    on('turbolinks:load', &method(:loaded))
    true
  end

  def loaded
    class_name = Element['body'].class_name
    if class_name == 'members index'
			# `$.tablesorter.addParser({
      #   // set a unique id
      #   id: 'dur',
      #   is: function(s) {
      #       // return false so this parser is not auto detected
      #       return false;
      #   },
      #   format: function(s) {
      #       // format your data for normalization
      #       return s.replace(/0:00/,'99:59');
      #   },
      #   // set type, either numeric or text
      #   type: 'text'
    	# });
			# $('#mem-table').tablesorter({
      #       headers: {
      #           5: {
      #               sorter:'dur'
      #           },
			# 					6: {
      #               sorter:'dur'
      #           }
      #       }
      #   });`
      Element.expose :tablesorter
      Element['#mem-table'].tablesorter
    end
  end

  # Register events on document to save memory and be friends to Turbolinks
  def on(event, selector = nil, &block)
    Element[`document`].on(event, selector, &block)
  end

end
MemberView.new.setup
