/* Code from:
http://stackoverflow.com/questions/5819807/any-good-codes-to-generate-toc-from-html-heading-elements-in-javascript
posted by Japboy, 2011.04.28
*/

$(function () {
  var assigned_level = 0,
      current_level = 0,
      id_number = 1,
      parent_node = "article",
      toc_html = '';

  $(parent_node + " *").each(function () {
    if (this.nodeName.length === 2 && this.nodeName.charAt(0) === "H") {
      $(this).attr("class", "heading");
    }
  });

  $("h1,h2,h3").each( function () {
    current_level = this.nodeName.charAt(1);

    $(this).attr('id', "toc-" + id_number);

    // Close a list if a same level list follows.
    if (assigned_level !== current_level - 1) {
      toc_html += "</li>"
    }

    // Open parent lists if a child list follows.
    while (assigned_level < current_level) {
      toc_html += "<ol>";
      assigned_level += 1;
    }

    // Close child lists and the parent list if
    // the same level parent list follows.
    while (assigned_level > current_level) {
      toc_html += "</ol></li>";
      assigned_level -= 1;
    }

    toc_html +=
      '<li><a href="#' + this.id + '">' + $(this).html() + "</a>";
    id_number += 1;
  });

  // Close everything
  while (assigned_level > 0) {
    toc_html += "</li></ol>";
    assigned_level -= 1;
  }

  $("#toc").html(toc_html);
});