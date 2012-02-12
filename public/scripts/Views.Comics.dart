#library('Collection View for My Comic Book Collection');

#import('HipsterView.dart');

class Comics extends HipsterView {
  Comics([collection, model, el]):
    super(collection:collection, model:model, el:el);

  post_initialize() {
    _subscribeEvents();
    _attachUiHandlers();
  }

  _subscribeEvents() {
    if (collection == null) return;

    collection.on.load.add((event) { render(); });
    collection.on.add.add((event) { render(); });
  }

  render() {
    el.innerHTML = template(collection);
  }

  template(list) {
    // This is silly, but [].forEach is broke
    if (list.length == 0) return '';

    var html = '';
    list.forEach((comic) {
      html += _singleComicBookTemplate(comic);
    });
    return html;
  }

  _singleComicBookTemplate(comic) {
    return """
      <li id="${comic['id']}">
        ${comic['title']}
        (${comic['author']})
        <a href="#" class="delete">[delete]</a>
      </li>
    """;
  }

  _attachUiHandlers() {
    attach_handler(el, 'click .delete', (event) {
      print("[delete] ${event.target.parent.id}");
      collection[event.target.parent.id].delete(callback:(_) {
        event.target.parent.remove();
      });
    });
  }

}